import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mhw_app/core/database/tables/enums.dart';

void main() {
  group('WeaponTypeConverter', () {
    const converter = WeaponTypeConverter();

    test('fromSql maps every stored key to the correct enum value', () {
      expect(converter.fromSql('gs'), WeaponType.gs);
      expect(converter.fromSql('ls'), WeaponType.ls);
      expect(converter.fromSql('sns'), WeaponType.sns);
      expect(converter.fromSql('db'), WeaponType.db);
      expect(converter.fromSql('hmr'), WeaponType.hmr);
      expect(converter.fromSql('hh'), WeaponType.hh);
      expect(converter.fromSql('lan'), WeaponType.lan);
      expect(converter.fromSql('gl'), WeaponType.gl);
      expect(converter.fromSql('sa'), WeaponType.sa);
      expect(converter.fromSql('cb'), WeaponType.cb);
      expect(converter.fromSql('ig'), WeaponType.ig);
      expect(converter.fromSql('lbg'), WeaponType.lbg);
      expect(converter.fromSql('hbg'), WeaponType.hbg);
      expect(converter.fromSql('bow'), WeaponType.bow);
    });

    test('toSql round-trips for all values', () {
      for (final v in WeaponType.values) {
        expect(converter.fromSql(converter.toSql(v)), v);
      }
    });

    test('toSql produces lowercase string matching enum name', () {
      expect(converter.toSql(WeaponType.gs), 'gs');
      expect(converter.toSql(WeaponType.hbg), 'hbg');
    });
  });

  group('ElementTypeConverter', () {
    const converter = ElementTypeConverter();

    test('fromSql maps all element types', () {
      expect(converter.fromSql('fire'), ElementType.fire);
      expect(converter.fromSql('water'), ElementType.water);
      expect(converter.fromSql('thunder'), ElementType.thunder);
      expect(converter.fromSql('ice'), ElementType.ice);
      expect(converter.fromSql('dragon'), ElementType.dragon);
    });

    test('toSql round-trips for all values', () {
      for (final v in ElementType.values) {
        expect(converter.fromSql(converter.toSql(v)), v);
      }
    });
  });

  group('DamageTypeConverter', () {
    const converter = DamageTypeConverter();

    test('fromSql maps all damage types', () {
      expect(converter.fromSql('cut'), DamageType.cut);
      expect(converter.fromSql('impact'), DamageType.impact);
      expect(converter.fromSql('ranged'), DamageType.ranged);
    });

    test('toSql round-trips for all values', () {
      for (final v in DamageType.values) {
        expect(converter.fromSql(converter.toSql(v)), v);
      }
    });
  });

  group('SharpnessLevelConverter', () {
    const converter = SharpnessLevelConverter();

    test('fromSql maps all sharpness levels in ascending order', () {
      expect(converter.fromSql('red'), SharpnessLevel.red);
      expect(converter.fromSql('orange'), SharpnessLevel.orange);
      expect(converter.fromSql('yellow'), SharpnessLevel.yellow);
      expect(converter.fromSql('green'), SharpnessLevel.green);
      expect(converter.fromSql('blue'), SharpnessLevel.blue);
      expect(converter.fromSql('white'), SharpnessLevel.white);
      expect(converter.fromSql('purple'), SharpnessLevel.purple);
    });

    test('toSql round-trips for all values', () {
      for (final v in SharpnessLevel.values) {
        expect(converter.fromSql(converter.toSql(v)), v);
      }
    });
  });

  group('ArmorSlotTypeConverter', () {
    const converter = ArmorSlotTypeConverter();

    test('fromSql maps all slot types', () {
      expect(converter.fromSql('head'), ArmorSlotType.head);
      expect(converter.fromSql('chest'), ArmorSlotType.chest);
      expect(converter.fromSql('arms'), ArmorSlotType.arms);
      expect(converter.fromSql('waist'), ArmorSlotType.waist);
      expect(converter.fromSql('legs'), ArmorSlotType.legs);
    });

    test('toSql round-trips for all values', () {
      for (final v in ArmorSlotType.values) {
        expect(converter.fromSql(converter.toSql(v)), v);
      }
    });
  });

  group('SkillCategoryConverter', () {
    const converter = SkillCategoryConverter();

    test('fromSql maps all skill categories (lowercase, as stored in DB)', () {
      expect(converter.fromSql('armor'), SkillCategory.armor);
      expect(converter.fromSql('group'), SkillCategory.group);
      expect(converter.fromSql('series'), SkillCategory.series);
      expect(converter.fromSql('weapon'), SkillCategory.weapon);
    });

    test('toSql round-trips for all values', () {
      for (final v in SkillCategory.values) {
        expect(converter.fromSql(converter.toSql(v)), v);
      }
    });
  });

  group('SkillSubcategoryConverter', () {
    const converter = SkillSubcategoryConverter();

    test('fromSql maps all skill subcategories', () {
      expect(converter.fromSql('defensive'), SkillSubcategory.defensive);
      expect(converter.fromSql('farming'), SkillSubcategory.farming);
      expect(converter.fromSql('offensive'), SkillSubcategory.offensive);
      expect(converter.fromSql('regen'), SkillSubcategory.regen);
      expect(converter.fromSql('technical'), SkillSubcategory.technical);
      expect(converter.fromSql('utility'), SkillSubcategory.utility);
    });

    test('toSql round-trips for all values', () {
      for (final v in SkillSubcategory.values) {
        expect(converter.fromSql(converter.toSql(v)), v);
      }
    });
  });

  group('SetSkillTypeConverter', () {
    const converter = SetSkillTypeConverter();

    test('fromSql maps group and series', () {
      expect(converter.fromSql('group'), SetSkillType.group);
      expect(converter.fromSql('series'), SetSkillType.series);
    });

    test('toSql round-trips for all values', () {
      for (final v in SetSkillType.values) {
        expect(converter.fromSql(converter.toSql(v)), v);
      }
    });
  });

  group('JewelSlotSourceConverter', () {
    const converter = JewelSlotSourceConverter();

    test('fromSql maps all slot sources', () {
      expect(converter.fromSql('weapon'), JewelSlotSource.weapon);
      expect(converter.fromSql('head'), JewelSlotSource.head);
      expect(converter.fromSql('chest'), JewelSlotSource.chest);
      expect(converter.fromSql('arms'), JewelSlotSource.arms);
      expect(converter.fromSql('waist'), JewelSlotSource.waist);
      expect(converter.fromSql('legs'), JewelSlotSource.legs);
      expect(converter.fromSql('talisman'), JewelSlotSource.talisman);
    });

    test('toSql round-trips for all values', () {
      for (final v in JewelSlotSource.values) {
        expect(converter.fromSql(converter.toSql(v)), v);
      }
    });
  });

  group('Converter invariants', () {
    test('all converters have full coverage: no stored key throws', () {
      // Ensures every enum value has a corresponding DB string and back.
      void roundTrip<T>(TypeConverter<T, String> c, List<T> values) {
        for (final v in values) {
          expect(() => c.fromSql(c.toSql(v)), returnsNormally,
              reason: '${v.toString()} failed round-trip');
        }
      }

      roundTrip(const WeaponTypeConverter(), WeaponType.values);
      roundTrip(const ElementTypeConverter(), ElementType.values);
      roundTrip(const DamageTypeConverter(), DamageType.values);
      roundTrip(const SharpnessLevelConverter(), SharpnessLevel.values);
      roundTrip(const ArmorSlotTypeConverter(), ArmorSlotType.values);
      roundTrip(const SkillCategoryConverter(), SkillCategory.values);
      roundTrip(const SkillSubcategoryConverter(), SkillSubcategory.values);
      roundTrip(const SetSkillTypeConverter(), SetSkillType.values);
      roundTrip(const JewelSlotSourceConverter(), JewelSlotSource.values);
    });
  });
}
