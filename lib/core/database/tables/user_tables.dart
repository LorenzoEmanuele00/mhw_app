import 'package:drift/drift.dart';
import 'game_tables.dart';
import 'enums.dart';

class Talismans extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  @ReferenceName('talismanSkill1Refs')
  IntColumn get skill1Id => integer().nullable().references(Skills, #id)();
  IntColumn get skill1Level => integer().nullable()();
  @ReferenceName('talismanSkill2Refs')
  IntColumn get skill2Id => integer().nullable().references(Skills, #id)();
  IntColumn get skill2Level => integer().nullable()();
  TextColumn get slots => text().withDefault(const Constant('[]'))(); // JSON array
  IntColumn get createdAt => integer()();
}

class Builds extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get weaponId => integer().nullable().references(Weapons, #id)();
  @ReferenceName('buildHeadRefs')
  IntColumn get headId => integer().nullable().references(ArmorPieces, #id)();
  @ReferenceName('buildChestRefs')
  IntColumn get chestId => integer().nullable().references(ArmorPieces, #id)();
  @ReferenceName('buildArmsRefs')
  IntColumn get armsId => integer().nullable().references(ArmorPieces, #id)();
  @ReferenceName('buildWaistRefs')
  IntColumn get waistId => integer().nullable().references(ArmorPieces, #id)();
  @ReferenceName('buildLegsRefs')
  IntColumn get legsId => integer().nullable().references(ArmorPieces, #id)();
  IntColumn get talismanId => integer().nullable().references(Talismans, #id)();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

class BuildJewels extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get buildId => integer().references(Builds, #id)();
  TextColumn get slotSource =>
      text().map(const JewelSlotSourceConverter())();
  IntColumn get slotIndex => integer()();
  IntColumn get jewelId => integer().references(Jewels, #id)();
}

class SyncMetadata extends Table {
  @override
  String get tableName => 'sync_metadata';
  TextColumn get tableNameCol => text()();
  IntColumn get lastVersion => integer().withDefault(const Constant(0))();
  IntColumn get lastSyncedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {tableNameCol};
}
