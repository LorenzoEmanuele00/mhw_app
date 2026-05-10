// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MHW Builder';

  @override
  String get navBuild => 'Build';

  @override
  String get navEquipment => 'Equipment';

  @override
  String get navStats => 'Stats';

  @override
  String get navLoadouts => 'Loadouts';

  @override
  String get equipWeapons => 'Weapons';

  @override
  String get equipArmor => 'Armor';

  @override
  String get equipCharm => 'Charm';

  @override
  String get armorSlotHead => 'Head';

  @override
  String get armorSlotChest => 'Chest';

  @override
  String get armorSlotArms => 'Arms';

  @override
  String get armorSlotWaist => 'Waist';

  @override
  String get armorSlotLegs => 'Legs';

  @override
  String get statAttack => 'Attack';

  @override
  String get statDefense => 'Defense';

  @override
  String get statAffinity => 'Affinity';

  @override
  String get statElement => 'Element';

  @override
  String get statSharpness => 'Sharpness';

  @override
  String get statRarity => 'Rarity';

  @override
  String get elemFire => 'Fire';

  @override
  String get elemWater => 'Water';

  @override
  String get elemThunder => 'Thunder';

  @override
  String get elemIce => 'Ice';

  @override
  String get elemDragon => 'Dragon';

  @override
  String get elemPoison => 'Poison';

  @override
  String get elemSleep => 'Sleep';

  @override
  String get elemParalysis => 'Paralysis';

  @override
  String get elemBlast => 'Blast';

  @override
  String get resistFire => 'Fire Res';

  @override
  String get resistWater => 'Water Res';

  @override
  String get resistThunder => 'Thunder Res';

  @override
  String get resistIce => 'Ice Res';

  @override
  String get resistDragon => 'Dragon Res';

  @override
  String get weaponTypeGs => 'Greatsword';

  @override
  String get weaponTypeLs => 'Longsword';

  @override
  String get weaponTypeSns => 'Sword & Shield';

  @override
  String get weaponTypeDb => 'Dual Blades';

  @override
  String get weaponTypeHmr => 'Hammer';

  @override
  String get weaponTypeHh => 'Hunting Horn';

  @override
  String get weaponTypeLan => 'Lance';

  @override
  String get weaponTypeGl => 'Gunlance';

  @override
  String get weaponTypeSa => 'Switch Axe';

  @override
  String get weaponTypeCb => 'Charge Blade';

  @override
  String get weaponTypeIg => 'Insect Glaive';

  @override
  String get weaponTypeLbg => 'Light Bowgun';

  @override
  String get weaponTypeHbg => 'Heavy Bowgun';

  @override
  String get weaponTypeBow => 'Bow';

  @override
  String get sharpnessRed => 'Red';

  @override
  String get sharpnessOrange => 'Orange';

  @override
  String get sharpnessYellow => 'Yellow';

  @override
  String get sharpnessGreen => 'Green';

  @override
  String get sharpnessBlue => 'Blue';

  @override
  String get sharpnessWhite => 'White';

  @override
  String get sharpnessPurple => 'Purple';

  @override
  String get sectionSkills => 'Skills';

  @override
  String get sectionDecoSlots => 'Decoration Slots';

  @override
  String get sectionWeapon => 'Weapon';

  @override
  String get sectionArmor => 'Armor';

  @override
  String detailRarity(int n) {
    return 'R$n';
  }

  @override
  String detailSlot(int index, int level) {
    return 'Slot $index · Level $level';
  }

  @override
  String get charmSkillsOnly =>
      'Charms grant skills only — no defense or resistances.';

  @override
  String catalogCount(int count) {
    return '$count items in catalog';
  }

  @override
  String get searchEquipment => 'Search equipment';

  @override
  String get searchJewels => 'Search jewels';

  @override
  String get filterButton => 'Filter';

  @override
  String searchNoResults(String query) {
    return 'Nothing matches \"$query\".';
  }

  @override
  String get comingSoon => 'Coming soon';

  @override
  String initError(Object error) {
    return 'Init error: $error';
  }
}
