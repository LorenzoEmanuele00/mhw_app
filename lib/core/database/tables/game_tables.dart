import 'package:drift/drift.dart';

class Weapons extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get weaponType => text()();
  IntColumn get baseAttack => integer()();
  RealColumn get baseAffinity => real().withDefault(const Constant(0.0))();
  TextColumn get elementType => text().nullable()();
  IntColumn get elementValue => integer().nullable()();
  TextColumn get sharpnessMax => text().withDefault(const Constant('white'))();
  IntColumn get rarity => integer().withDefault(const Constant(1))();
  TextColumn get slots => text().withDefault(const Constant('[]'))(); // JSON
  RealColumn get rmv => real().withDefault(const Constant(1.0))();
  RealColumn get emv => real().withDefault(const Constant(1.0))();
  TextColumn get damageType => text().withDefault(const Constant('cut'))();
  TextColumn get burstGroup => text().withDefault(const Constant('Other'))();

  @override
  Set<Column> get primaryKey => {id};
}

class ArmorPieces extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get slotType => text()(); // head/chest/arms/waist/legs
  IntColumn get baseDefense => integer().withDefault(const Constant(0))();
  IntColumn get fireRes => integer().withDefault(const Constant(0))();
  IntColumn get waterRes => integer().withDefault(const Constant(0))();
  IntColumn get thunderRes => integer().withDefault(const Constant(0))();
  IntColumn get iceRes => integer().withDefault(const Constant(0))();
  IntColumn get dragonRes => integer().withDefault(const Constant(0))();
  IntColumn get rarity => integer().withDefault(const Constant(1))();
  TextColumn get slots => text().withDefault(const Constant('[]'))(); // JSON
  TextColumn get setId => text().references(ArmorSets, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

class ArmorSets extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class ArmorSetSkills extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get setId => text().references(ArmorSets, #id)();
  IntColumn get requiredPieces => integer()();
  TextColumn get skillId => text().references(Skills, #id)();
  IntColumn get skillLevel => integer()();
  TextColumn get skillCategory => text()(); // GROUP / SERIES
}

class Jewels extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get rarity => integer().withDefault(const Constant(1))();
  IntColumn get slotSize => integer()();
  TextColumn get skillId => text().references(Skills, #id)();
  IntColumn get skillLevel => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class Skills extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get maxLevel => integer()();
  TextColumn get type1 => text().withDefault(const Constant('Armor'))();
  TextColumn get type2 => text().withDefault(const Constant('Utility'))();

  @override
  Set<Column> get primaryKey => {id};
}

class SkillLevels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get skillId => text().references(Skills, #id)();
  IntColumn get level => integer()();
  RealColumn get bonus1Value => real().nullable()();
  TextColumn get bonus1Type => text().nullable()();
  RealColumn get bonus2Value => real().nullable()();
  TextColumn get bonus2Type => text().nullable()();
  RealColumn get bonus3Value => real().nullable()();
  TextColumn get bonus3Type => text().nullable()();
  RealColumn get durationS => real().nullable()();
  RealColumn get cooldownS => real().nullable()();
}

// Tipi bonus validi (documentazione):
// atk_multiplier, atk_additive, affinity_additive, crit_bonus_multiplier
// elem_multiplier, elem_additive, def_multiplier, def_additive
// fire_res_additive, water_res_additive, thunder_res_additive,
// ice_res_additive, dragon_res_additive, sharpness_additive
