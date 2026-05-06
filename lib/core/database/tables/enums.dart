import 'package:drift/drift.dart';

// ---------------------------------------------------------------------------
// Weapon enums
// ---------------------------------------------------------------------------

enum WeaponType { gs, ls, sns, db, hmr, hh, lan, gl, sa, cb, ig, lbg, hbg, bow }

enum ElementType { fire, water, thunder, ice, dragon }

enum DamageType { cut, impact, ranged }

enum SharpnessLevel { red, orange, yellow, green, blue, white, purple }

// ---------------------------------------------------------------------------
// Armor enums
// ---------------------------------------------------------------------------

enum ArmorSlotType { head, chest, arms, waist, legs }

// ---------------------------------------------------------------------------
// Skill enums
// ---------------------------------------------------------------------------

/// Primary skill category — stored in skills.type1
enum SkillCategory { armor, group, series, weapon }

/// Secondary skill category — stored in skills.type2
enum SkillSubcategory { defensive, farming, offensive, regen, technical, utility }

/// Armor set skill type — stored in armor_set_skills.skill_category
enum SetSkillType { group, series }

// ---------------------------------------------------------------------------
// Build / jewel enums
// ---------------------------------------------------------------------------

enum JewelSlotSource { weapon, head, chest, arms, waist, legs, talisman }

// ---------------------------------------------------------------------------
// TypeConverters — pure Dart-layer, no SQL schema change
// ---------------------------------------------------------------------------

class WeaponTypeConverter extends TypeConverter<WeaponType, String> {
  const WeaponTypeConverter();
  @override
  WeaponType fromSql(String s) => WeaponType.values.byName(s);
  @override
  String toSql(WeaponType v) => v.name;
}

class ElementTypeConverter extends TypeConverter<ElementType, String> {
  const ElementTypeConverter();
  @override
  ElementType fromSql(String s) => ElementType.values.byName(s);
  @override
  String toSql(ElementType v) => v.name;
}

class DamageTypeConverter extends TypeConverter<DamageType, String> {
  const DamageTypeConverter();
  @override
  DamageType fromSql(String s) => DamageType.values.byName(s);
  @override
  String toSql(DamageType v) => v.name;
}

class SharpnessLevelConverter extends TypeConverter<SharpnessLevel, String> {
  const SharpnessLevelConverter();
  @override
  SharpnessLevel fromSql(String s) => SharpnessLevel.values.byName(s);
  @override
  String toSql(SharpnessLevel v) => v.name;
}

class ArmorSlotTypeConverter extends TypeConverter<ArmorSlotType, String> {
  const ArmorSlotTypeConverter();
  @override
  ArmorSlotType fromSql(String s) => ArmorSlotType.values.byName(s);
  @override
  String toSql(ArmorSlotType v) => v.name;
}

class SkillCategoryConverter extends TypeConverter<SkillCategory, String> {
  const SkillCategoryConverter();
  @override
  SkillCategory fromSql(String s) => SkillCategory.values.byName(s);
  @override
  String toSql(SkillCategory v) => v.name;
}

class SkillSubcategoryConverter extends TypeConverter<SkillSubcategory, String> {
  const SkillSubcategoryConverter();
  @override
  SkillSubcategory fromSql(String s) => SkillSubcategory.values.byName(s);
  @override
  String toSql(SkillSubcategory v) => v.name;
}

class SetSkillTypeConverter extends TypeConverter<SetSkillType, String> {
  const SetSkillTypeConverter();
  @override
  SetSkillType fromSql(String s) => SetSkillType.values.byName(s);
  @override
  String toSql(SetSkillType v) => v.name;
}

class JewelSlotSourceConverter extends TypeConverter<JewelSlotSource, String> {
  const JewelSlotSourceConverter();
  @override
  JewelSlotSource fromSql(String s) => JewelSlotSource.values.byName(s);
  @override
  String toSql(JewelSlotSource v) => v.name;
}
