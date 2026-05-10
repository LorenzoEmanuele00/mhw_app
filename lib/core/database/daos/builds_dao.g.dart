// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'builds_dao.dart';

// ignore_for_file: type=lint
mixin _$BuildsDaoMixin on DatabaseAccessor<AppDatabase> {
  $WeaponsTable get weapons => attachedDatabase.weapons;
  $ArmorSetsTable get armorSets => attachedDatabase.armorSets;
  $ArmorPiecesTable get armorPieces => attachedDatabase.armorPieces;
  $SkillsTable get skills => attachedDatabase.skills;
  $TalismansTable get talismans => attachedDatabase.talismans;
  $BuildsTable get builds => attachedDatabase.builds;
  $JewelsTable get jewels => attachedDatabase.jewels;
  $BuildJewelsTable get buildJewels => attachedDatabase.buildJewels;
  BuildsDaoManager get managers => BuildsDaoManager(this);
}

class BuildsDaoManager {
  final _$BuildsDaoMixin _db;
  BuildsDaoManager(this._db);
  $$WeaponsTableTableManager get weapons =>
      $$WeaponsTableTableManager(_db.attachedDatabase, _db.weapons);
  $$ArmorSetsTableTableManager get armorSets =>
      $$ArmorSetsTableTableManager(_db.attachedDatabase, _db.armorSets);
  $$ArmorPiecesTableTableManager get armorPieces =>
      $$ArmorPiecesTableTableManager(_db.attachedDatabase, _db.armorPieces);
  $$SkillsTableTableManager get skills =>
      $$SkillsTableTableManager(_db.attachedDatabase, _db.skills);
  $$TalismansTableTableManager get talismans =>
      $$TalismansTableTableManager(_db.attachedDatabase, _db.talismans);
  $$BuildsTableTableManager get builds =>
      $$BuildsTableTableManager(_db.attachedDatabase, _db.builds);
  $$JewelsTableTableManager get jewels =>
      $$JewelsTableTableManager(_db.attachedDatabase, _db.jewels);
  $$BuildJewelsTableTableManager get buildJewels =>
      $$BuildJewelsTableTableManager(_db.attachedDatabase, _db.buildJewels);
}
