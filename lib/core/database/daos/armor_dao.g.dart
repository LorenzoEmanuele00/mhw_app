// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'armor_dao.dart';

// ignore_for_file: type=lint
mixin _$ArmorDaoMixin on DatabaseAccessor<AppDatabase> {
  $ArmorSetsTable get armorSets => attachedDatabase.armorSets;
  $ArmorPiecesTable get armorPieces => attachedDatabase.armorPieces;
  $SkillsTable get skills => attachedDatabase.skills;
  $ArmorSetSkillsTable get armorSetSkills => attachedDatabase.armorSetSkills;
  ArmorDaoManager get managers => ArmorDaoManager(this);
}

class ArmorDaoManager {
  final _$ArmorDaoMixin _db;
  ArmorDaoManager(this._db);
  $$ArmorSetsTableTableManager get armorSets =>
      $$ArmorSetsTableTableManager(_db.attachedDatabase, _db.armorSets);
  $$ArmorPiecesTableTableManager get armorPieces =>
      $$ArmorPiecesTableTableManager(_db.attachedDatabase, _db.armorPieces);
  $$SkillsTableTableManager get skills =>
      $$SkillsTableTableManager(_db.attachedDatabase, _db.skills);
  $$ArmorSetSkillsTableTableManager get armorSetSkills =>
      $$ArmorSetSkillsTableTableManager(
        _db.attachedDatabase,
        _db.armorSetSkills,
      );
}
