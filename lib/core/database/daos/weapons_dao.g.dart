// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weapons_dao.dart';

// ignore_for_file: type=lint
mixin _$WeaponsDaoMixin on DatabaseAccessor<AppDatabase> {
  $WeaponsTable get weapons => attachedDatabase.weapons;
  WeaponsDaoManager get managers => WeaponsDaoManager(this);
}

class WeaponsDaoManager {
  final _$WeaponsDaoMixin _db;
  WeaponsDaoManager(this._db);
  $$WeaponsTableTableManager get weapons =>
      $$WeaponsTableTableManager(_db.attachedDatabase, _db.weapons);
}
