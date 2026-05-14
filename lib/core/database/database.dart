import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/enums.dart';
import 'tables/game_tables.dart';
import 'tables/user_tables.dart';
import 'daos/weapons_dao.dart';
import 'daos/armor_dao.dart';
import 'daos/skills_dao.dart';
import 'daos/builds_dao.dart';
import 'daos/talismans_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Weapons,
    ArmorPieces,
    ArmorSets,
    ArmorSetSkills,
    ArmorPieceSkills,
    Jewels,
    JewelSkills,
    Skills,
    SkillLevels,
    Talismans,
    Builds,
    BuildJewels,
    SyncMetadata,
  ],
  daos: [
    WeaponsDao,
    ArmorDao,
    SkillsDao,
    BuildsDao,
    TalismansDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedSyncMetadata();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            // v2: nuclear reset — schema changed too broadly, easier to recreate.
            await m.drop(buildJewels);
            await m.drop(builds);
            await m.drop(talismans);
            await m.drop(armorSetSkills);
            await m.drop(skillLevels);
            await m.drop(jewels);
            await m.drop(armorPieces);
            await m.drop(armorSets);
            await m.drop(weapons);
            await m.drop(skills);
            await m.createAll();
            await _seedSyncMetadata();
            return; // createAll already applies all subsequent schema changes
          }
          if (from < 3) {
            // v3: add pieces_required to skill_levels.
            await customStatement(
              'ALTER TABLE skill_levels ADD COLUMN pieces_required INTEGER',
            );
          }
          if (from < 4) {
            // v4: armor_piece_skills + jewel_skills tables; jewels loses skillId/skillLevel,
            //     gains allowed_on. Drop jewels (game data, no user content) then recreate.
            await customStatement('DROP TABLE IF EXISTS build_jewels');
            await customStatement('DROP TABLE IF EXISTS jewels');
            await m.createTable(jewels);
            await m.createTable(buildJewels);
            await m.createTable(armorPieceSkills);
            await m.createTable(jewelSkills);
          }
        },
      );

  Future<void> _seedSyncMetadata() async {
    const tables = [
      'weapons', 'armor_pieces', 'armor_sets', 'armor_set_skills',
      'armor_piece_skills', 'jewels', 'jewel_skills', 'skills', 'skill_levels',
    ];
    for (final table in tables) {
      await into(syncMetadata).insertOnConflictUpdate(
        SyncMetadataCompanion.insert(tableNameCol: table),
      );
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'mhw_app.db'));
    return NativeDatabase.createInBackground(
      file,
      setup: (rawDb) {
        // Force WAL checkpoint on open so stale WAL/SHM files from a previous
        // session (e.g. app killed by iOS watchdog) don't cause open failures.
        rawDb.execute('PRAGMA wal_checkpoint(FULL)');
      },
    );
  });
}
