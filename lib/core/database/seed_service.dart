import 'package:flutter/services.dart';
import 'database.dart';

/// Carica i seed SQL negli asset al primo avvio (DB vuoto).
/// Viene chiamato una sola volta durante l'init dell'app.
class SeedService {
  final AppDatabase _db;

  SeedService(this._db);

  static const _seeds = [
    'assets/seeds/01_skills.sql',
    'assets/seeds/02_skill_levels.sql',
  ];

  Future<void> seedIfEmpty() async {
    final count = await _db.customSelect(
      'SELECT COUNT(*) as c FROM skills',
    ).map((row) => row.read<int>('c')).getSingleOrNull() ?? 0;

    if (count > 0) return;

    await _db.transaction(() async {
      for (final assetPath in _seeds) {
        final sql = await rootBundle.loadString(assetPath);
        final statements = _splitStatements(sql);
        for (final stmt in statements) {
          await _db.customStatement(stmt);
        }
      }
    });
  }

  /// Divide il file SQL in statement singoli, saltando commenti e righe vuote.
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
