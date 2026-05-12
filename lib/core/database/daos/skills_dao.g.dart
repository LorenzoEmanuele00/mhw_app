// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skills_dao.dart';

// ignore_for_file: type=lint
mixin _$SkillsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SkillsTable get skills => attachedDatabase.skills;
  $SkillLevelsTable get skillLevels => attachedDatabase.skillLevels;
  $JewelsTable get jewels => attachedDatabase.jewels;
  $JewelSkillsTable get jewelSkills => attachedDatabase.jewelSkills;
  SkillsDaoManager get managers => SkillsDaoManager(this);
}

class SkillsDaoManager {
  final _$SkillsDaoMixin _db;
  SkillsDaoManager(this._db);
  $$SkillsTableTableManager get skills =>
      $$SkillsTableTableManager(_db.attachedDatabase, _db.skills);
  $$SkillLevelsTableTableManager get skillLevels =>
      $$SkillLevelsTableTableManager(_db.attachedDatabase, _db.skillLevels);
  $$JewelsTableTableManager get jewels =>
      $$JewelsTableTableManager(_db.attachedDatabase, _db.jewels);
  $$JewelSkillsTableTableManager get jewelSkills =>
      $$JewelSkillsTableTableManager(_db.attachedDatabase, _db.jewelSkills);
}
