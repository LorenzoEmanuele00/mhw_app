import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mhw_app/core/database/database.dart';
import 'package:mhw_app/core/sync/sync_service.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('offline → SyncStatus.offline', () async {
    final service = SyncService(db, isOnline: () async => false);
    final result = await service.checkAndSync();
    expect(result.status, SyncStatus.offline);
    expect(result.tablesUpdated, 0);
  });

  test('online, empty remote versions → SyncStatus.upToDate', () async {
    final service = SyncService(
      db,
      isOnline: () async => true,
      fetchRemoteVersions: () async => {},
      fetchRows: (_) async => [],
    );
    final result = await service.checkAndSync();
    expect(result.status, SyncStatus.upToDate);
  });

  test('online, remote versions match local (all 0) → SyncStatus.upToDate',
      () async {
    final service = SyncService(
      db,
      isOnline: () async => true,
      fetchRemoteVersions: () async =>
          {for (final t in SyncService.syncTables) t: 0},
      fetchRows: (_) async => [],
    );
    final result = await service.checkAndSync();
    expect(result.status, SyncStatus.upToDate);
    expect(result.tablesUpdated, 0);
  });

  test('online, skills remote > local → replaces rows and updates metadata',
      () async {
    final testSkillRow = {
      'id': 999,
      'slug': 'test-skill',
      'name': 'Test Skill',
      'description': null,
      'description_it': null,
      'max_level': 1,
      'type1': 'armor',
      'type2': 'offensive',
    };
    final service = SyncService(
      db,
      isOnline: () async => true,
      fetchRemoteVersions: () async => {
        'skills': 1,
        ...{
          for (final t in SyncService.syncTables.where((t) => t != 'skills'))
            t: 0,
        },
      },
      fetchRows: (table) async => table == 'skills' ? [testSkillRow] : [],
    );

    final result = await service.checkAndSync();

    expect(result.status, SyncStatus.updated);
    expect(result.tablesUpdated, 1);

    final skills = await db.select(db.skills).get();
    expect(skills.any((s) => s.slug == 'test-skill'), isTrue);

    final meta = await (db.select(db.syncMetadata)
          ..where((t) => t.tableNameCol.equals('skills')))
        .getSingle();
    expect(meta.lastVersion, 1);
    expect(meta.lastSyncedAt, isNotNull);
  });

  test('multiple tables outdated → tablesUpdated reflects count', () async {
    final service = SyncService(
      db,
      isOnline: () async => true,
      fetchRemoteVersions: () async => {
        'skills': 1,
        'weapons': 1,
        ...{
          for (final t in SyncService.syncTables
              .where((t) => t != 'skills' && t != 'weapons'))
            t: 0,
        },
      },
      fetchRows: (_) async => [],
    );

    final result = await service.checkAndSync();
    expect(result.status, SyncStatus.updated);
    expect(result.tablesUpdated, 2);
  });

  test('remote version > local but empty rows → local data preserved',
      () async {
    // Pre-seed a skill row to simulate data from the local SQL seed.
    await db.customStatement(
      "INSERT INTO skills (id, slug, name, max_level, type1) "
      "VALUES (1, 'test-skill', 'Test Skill', 1, 'armor')",
    );

    final service = SyncService(
      db,
      isOnline: () async => true,
      fetchRemoteVersions: () async => {'skills': 1},
      fetchRows: (_) async => [], // Supabase table is empty / RLS blocks reads
    );

    await service.checkAndSync();

    // Local seed data must survive an empty remote response.
    final skills = await db.select(db.skills).get();
    expect(skills.length, 1);
    expect(skills.first.slug, 'test-skill');
  });

  test('network error during version fetch → SyncStatus.error', () async {
    final service = SyncService(
      db,
      isOnline: () async => true,
      fetchRemoteVersions: () async => throw Exception('Network error'),
    );
    final result = await service.checkAndSync();
    expect(result.status, SyncStatus.error);
    expect(result.error, contains('Network error'));
  });
}
