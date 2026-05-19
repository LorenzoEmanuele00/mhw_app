import 'package:drift/drift.dart';
import 'enums.dart';

class Weapons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get slug => text()();
  TextColumn get name => text()();
  TextColumn get weaponType => text().map(const WeaponTypeConverter())();
  IntColumn get baseAttack => integer()();
  RealColumn get baseAffinity => real().withDefault(const Constant(0.0))();
  TextColumn get elementType =>
      text().nullable().map(const ElementTypeConverter())();
  IntColumn get elementValue => integer().nullable()();
  TextColumn get sharpnessMax =>
      text().withDefault(const Constant('white')).map(const SharpnessLevelConverter())();
  IntColumn get rarity => integer().withDefault(const Constant(1))();
  TextColumn get slots => text().withDefault(const Constant('[]'))(); // JSON array
  RealColumn get rmv => real().withDefault(const Constant(1.0))();
  RealColumn get emv => real().withDefault(const Constant(1.0))();
  TextColumn get damageType =>
      text().withDefault(const Constant('cut')).map(const DamageTypeConverter())();
  TextColumn get burstGroup => text().withDefault(const Constant('Other'))();

  @override
  List<Set<Column>> get uniqueKeys => [{slug}];
}

class ArmorPieces extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get slug => text()();
  TextColumn get name => text()();
  TextColumn get slotType => text().map(const ArmorSlotTypeConverter())();
  IntColumn get baseDefense => integer().withDefault(const Constant(0))();
  IntColumn get fireRes => integer().withDefault(const Constant(0))();
  IntColumn get waterRes => integer().withDefault(const Constant(0))();
  IntColumn get thunderRes => integer().withDefault(const Constant(0))();
  IntColumn get iceRes => integer().withDefault(const Constant(0))();
  IntColumn get dragonRes => integer().withDefault(const Constant(0))();
  IntColumn get rarity => integer().withDefault(const Constant(1))();
  TextColumn get slots => text().withDefault(const Constant('[]'))(); // JSON array
  IntColumn get setId => integer().references(ArmorSets, #id)();

  @override
  List<Set<Column>> get uniqueKeys => [{slug}];
}

class ArmorSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get slug => text()();
  TextColumn get name => text()();

  @override
  List<Set<Column>> get uniqueKeys => [{slug}];
}

class ArmorSetSkills extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get setId => integer().references(ArmorSets, #id)();
  IntColumn get requiredPieces => integer()();
  IntColumn get skillId => integer().references(Skills, #id)();
  IntColumn get skillLevel => integer()();
  TextColumn get skillCategory =>
      text().map(const SetSkillTypeConverter())();
}

class Jewels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get slug => text()();
  TextColumn get name => text()();
  IntColumn get rarity => integer().withDefault(const Constant(1))();
  IntColumn get slotSize => integer()();
  // allowed_on: 'armor' or 'weapon' — constrains which slot this jewel can go into.
  TextColumn get allowedOn => text().withDefault(const Constant('armor'))();

  @override
  List<Set<Column>> get uniqueKeys => [{slug}];
}

class JewelSkills extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get jewelId => integer().references(Jewels, #id)();
  IntColumn get skillId => integer().references(Skills, #id)();
  IntColumn get skillLevel => integer()();
}

class ArmorPieceSkills extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get armorPieceId => integer().references(ArmorPieces, #id)();
  IntColumn get skillId => integer().references(Skills, #id)();
  IntColumn get skillLevel => integer()();
}

class Skills extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get slug => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get descriptionIt => text().nullable()();
  IntColumn get maxLevel => integer()();
  TextColumn get type1 =>
      text().withDefault(const Constant('armor')).map(const SkillCategoryConverter())();
  TextColumn get type2 =>
      text().withDefault(const Constant('utility')).map(const SkillSubcategoryConverter())();

  @override
  List<Set<Column>> get uniqueKeys => [{slug}];
}

class SkillLevels extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get skillId => integer().references(Skills, #id)();
  IntColumn get level => integer()();
  TextColumn get description => text().nullable()();
  TextColumn get descriptionIt => text().nullable()();
  // Null for armor/weapon skills; for set/group skills: armor pieces required to activate this level.
  IntColumn get piecesRequired => integer().nullable()();
  RealColumn get bonus1Value => real().nullable()();
  TextColumn get bonus1Type => text().nullable()();
  RealColumn get bonus2Value => real().nullable()();
  TextColumn get bonus2Type => text().nullable()();
  RealColumn get bonus3Value => real().nullable()();
  TextColumn get bonus3Type => text().nullable()();
  RealColumn get durationS => real().nullable()();
  RealColumn get cooldownS => real().nullable()();
}

// Valid bonus types for the calc engine (bonusXType fields above):
// atk_multiplier, atk_additive, affinity_additive, crit_bonus_multiplier
// elem_multiplier, elem_additive, def_multiplier, def_additive
// fire_res_additive, water_res_additive, thunder_res_additive,
// ice_res_additive, dragon_res_additive, sharpness_additive
// Other values are descriptive text for non-calc skills.
