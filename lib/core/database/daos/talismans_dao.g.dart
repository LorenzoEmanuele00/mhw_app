// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talismans_dao.dart';

// ignore_for_file: type=lint
mixin _$TalismansDaoMixin on DatabaseAccessor<AppDatabase> {
  $SkillsTable get skills => attachedDatabase.skills;
  $TalismansTable get talismans => attachedDatabase.talismans;
  TalismansDaoManager get managers => TalismansDaoManager(this);
}

class TalismansDaoManager {
  final _$TalismansDaoMixin _db;
  TalismansDaoManager(this._db);
  $$SkillsTableTableManager get skills =>
      $$SkillsTableTableManager(_db.attachedDatabase, _db.skills);
  $$TalismansTableTableManager get talismans =>
      $$TalismansTableTableManager(_db.attachedDatabase, _db.talismans);
}
