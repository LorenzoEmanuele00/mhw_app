import 'package:drift/drift.dart';
import 'game_tables.dart';
import 'enums.dart';

class Talismans extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  @ReferenceName('talismanSkill1Refs')
  TextColumn get skill1Id => text().nullable().references(Skills, #id)();
  IntColumn get skill1Level => integer().nullable()();
  @ReferenceName('talismanSkill2Refs')
  TextColumn get skill2Id => text().nullable().references(Skills, #id)();
  IntColumn get skill2Level => integer().nullable()();
  TextColumn get slots => text().withDefault(const Constant('[]'))(); // JSON array
  IntColumn get createdAt => integer()();
}

class Builds extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get weaponId => text().nullable().references(Weapons, #id)();
  @ReferenceName('buildHeadRefs')
  TextColumn get headId => text().nullable().references(ArmorPieces, #id)();
  @ReferenceName('buildChestRefs')
  TextColumn get chestId => text().nullable().references(ArmorPieces, #id)();
  @ReferenceName('buildArmsRefs')
  TextColumn get armsId => text().nullable().references(ArmorPieces, #id)();
  @ReferenceName('buildWaistRefs')
  TextColumn get waistId => text().nullable().references(ArmorPieces, #id)();
  @ReferenceName('buildLegsRefs')
  TextColumn get legsId => text().nullable().references(ArmorPieces, #id)();
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
  TextColumn get jewelId => text().references(Jewels, #id)();
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
