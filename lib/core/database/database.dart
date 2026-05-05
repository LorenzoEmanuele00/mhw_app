import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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
    Jewels,
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

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedSyncMetadata();
        },
      );

  Future<void> _seedSyncMetadata() async {
    const tables = [
      'weapons', 'armor_pieces', 'armor_sets',
      'armor_set_skills', 'jewels', 'skills', 'skill_levels',
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
    return NativeDatabase.createInBackground(file);
  });
}
