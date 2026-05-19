import 'package:flutter/services.dart';
import 'database.dart';

/// Loads SQL seed assets on first launch (empty DB).
/// Called once during app initialization.
class SeedService {
  final AppDatabase _db;

  SeedService(this._db);

  static const _seeds = [
    'assets/seeds/01_skills.sql',
    'assets/seeds/02_skill_levels.sql',
    'assets/seeds/03_armor.sql',
    'assets/seeds/04_weapons.sql',
    'assets/seeds/05_jewels.sql',
  ];

  Future<void> seedIfEmpty() async {
    final skillCount = await _db.customSelect(
      'SELECT COUNT(*) as c FROM skills',
    ).map((row) => row.read<int>('c')).getSingleOrNull() ?? 0;

    if (skillCount == 0) {
      await _db.transaction(() async {
        for (final assetPath in _seeds) {
          await _runSeedAsset(assetPath);
        }
      });
      return;
    }

    // Skills already present — re-seed skill_levels if a migration cleared them.
    final levelCount = await _db.customSelect(
      'SELECT COUNT(*) as c FROM skill_levels',
    ).map((row) => row.read<int>('c')).getSingleOrNull() ?? 0;

    if (levelCount == 0) {
      await _db.transaction(() async {
        await _runSeedAsset('assets/seeds/02_skill_levels.sql');
      });
    }
  }

  Future<void> _runSeedAsset(String assetPath) async {
    final sql = await rootBundle.loadString(assetPath);
    for (final stmt in _splitStatements(sql)) {
      await _db.customStatement(stmt);
    }
  }

  /// Splits a SQL file into individual statements, skipping comments and blank lines.
  List<String> _splitStatements(String sql) {
    final results = <String>[];
    final buffer = StringBuffer();

    for (final line in sql.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.startsWith('--') || trimmed.isEmpty) continue;
      buffer.write(' $trimmed');
      if (trimmed.endsWith(';')) {
        final stmt = buffer.toString().trim();
        if (stmt.isNotEmpty && stmt != ';') results.add(stmt);
        buffer.clear();
      }
    }

    return results;
  }
}
