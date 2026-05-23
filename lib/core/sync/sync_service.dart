import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../database/database.dart';

enum SyncStatus { offline, upToDate, updated, error }

class SyncResult {
  final SyncStatus status;
  final int tablesUpdated;
  final String? error;

  const SyncResult({
    required this.status,
    this.tablesUpdated = 0,
    this.error,
  });
}

typedef OnlineChecker = Future<bool> Function();
typedef VersionFetcher = Future<Map<String, int>> Function();
typedef RowsFetcher = Future<List<Map<String, dynamic>>> Function(String table);

class SyncService {
  final AppDatabase _db;
  final OnlineChecker _isOnline;
  final VersionFetcher _fetchRemoteVersions;
  final RowsFetcher _fetchRows;

  // FK-safe insertion order (parents before children).
  static const syncTables = [
    'skills',
    'skill_levels',
    'armor_sets',
    'armor_pieces',
    'armor_set_skills',
    'armor_piece_skills',
    'weapons',
    'jewels',
    'jewel_skills',
  ];

  SyncService(
    this._db, {
    OnlineChecker? isOnline,
    VersionFetcher? fetchRemoteVersions,
    RowsFetcher? fetchRows,
  })  : _isOnline = isOnline ?? _defaultOnlineCheck,
        _fetchRemoteVersions = fetchRemoteVersions ?? _defaultVersionFetcher,
        _fetchRows = fetchRows ?? _defaultRowsFetcher;

  static Future<bool> _defaultOnlineCheck() async {
    final results = await Connectivity().checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }

  static Future<Map<String, int>> _defaultVersionFetcher() async {
    final rows =
        await Supabase.instance.client.from('data_versions').select();
    return {
      for (final row in rows)
        (row['table_name'] as String): (row['version'] as int),
    };
  }

  static Future<List<Map<String, dynamic>>> _defaultRowsFetcher(
      String table) async {
    return Supabase.instance.client.from(table).select().limit(5000);
  }

  Future<SyncResult> checkAndSync() async {
    if (!await _isOnline()) {
      return const SyncResult(status: SyncStatus.offline);
    }

    try {
      final remoteVersions = await _fetchRemoteVersions();
      if (remoteVersions.isEmpty) {
        return const SyncResult(status: SyncStatus.upToDate);
      }

      final localVersions = await _getLocalVersions();

      var tablesUpdated = 0;
      for (final table in syncTables) {
        final remoteV = remoteVersions[table] ?? 0;
        final localV = localVersions[table] ?? 0;
        if (remoteV > localV) {
          final rows = await _fetchRows(table);
          await _replaceTable(table, rows, remoteV);
          tablesUpdated++;
        }
      }

      return SyncResult(
        status: tablesUpdated > 0 ? SyncStatus.updated : SyncStatus.upToDate,
        tablesUpdated: tablesUpdated,
      );
    } catch (e) {
      return SyncResult(status: SyncStatus.error, error: e.toString());
    }
  }

  Future<Map<String, int>> _getLocalVersions() async {
    final rows = await _db.select(_db.syncMetadata).get();
    return {for (final r in rows) r.tableNameCol: r.lastVersion};
  }

  Future<void> _replaceTable(
    String table,
    List<Map<String, dynamic>> rows,
    int version,
  ) async {
    // Don't wipe local data if remote returned nothing — Supabase table may be
    // empty or RLS may be blocking reads. Treat as "no update available".
    if (rows.isEmpty) return;

    await _db.transaction(() async {
      await _db.customStatement('DELETE FROM $table');
      for (final row in rows) {
        if (row.isEmpty) continue;
        final cols = row.keys.join(', ');
        final placeholders =
            List.generate(row.length, (_) => '?').join(', ');
        await _db.customStatement(
          'INSERT INTO $table ($cols) VALUES ($placeholders)',
          row.values.map(_coerce).toList(),
        );
      }
      await (_db.update(_db.syncMetadata)
            ..where((t) => t.tableNameCol.equals(table)))
          .write(SyncMetadataCompanion(
        lastVersion: Value(version),
        lastSyncedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));
    });
  }

  // Converts Supabase JSON values to SQLite-compatible types.
  // Booleans → int (SQLite has no native bool).
  static dynamic _coerce(dynamic v) {
    if (v is bool) return v ? 1 : 0;
    return v;
  }
}
