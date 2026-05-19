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
  String get buildSlotEmpty => 'Empty slot';

  @override
  String get buildNoWeapon => 'No weapon equipped';

  @override
  String get buildActiveSkills => 'Active Skills';

  @override
  String get buildNoSkills => 'No skills active';

  @override
  String get buildSummary => 'Summary';

  @override
  String get slotPickerSelectWeapon => 'Select Weapon';

  @override
  String slotPickerSelectArmor(String slot) {
    return 'Select $slot';
  }

  @override
  String get slotPickerSelectCharm => 'Select Charm';

  @override
  String get slotPickerClear => 'Clear';

  @override
  String get jewelPickerTitle => 'Select Decoration';

  @override
  String jewelPickerSlotLevel(int level) {
    return 'Level $level slot';
  }

  @override
  String get jewelPickerAvailable => 'Available';

  @override
  String get jewelPickerTooLarge => 'Need a larger slot';

  @override
  String get jewelPickerEmpty => 'No slot selected';

  @override
  String jewelSkillLabel(int level) {
    return 'Lv $level';
  }

  @override
  String get equipTo => 'Equip';

  @override
  String get equipChange => 'Change';

  @override
  String get equipped => 'Equipped';

  @override
  String get loadoutsNew => 'New';

  @override
  String get loadoutsEmpty => 'No builds yet';

  @override
  String get loadoutsEmptyHint => 'Tap + New to create your first build.';

  @override
  String get loadoutsDeleteTitle => 'Delete Build?';

  @override
  String loadoutsDeleteMessage(String name) {
    return 'This will permanently delete \"$name\".';
  }

  @override
  String get loadoutsDeleteConfirm => 'Delete';

  @override
  String get loadoutsCancel => 'Cancel';

  @override
  String get loadoutsRenameTitle => 'Rename Build';

  @override
  String get loadoutsRenameHint => 'Build name';

  @override
  String get loadoutsRenameSave => 'Save';

  @override
  String get loadoutsActive => 'Active';

  @override
  String get loadoutsAtk => 'ATK';

  @override
  String get loadoutsDef => 'DEF';

  @override
  String get statsResistances => 'Resistances';

  @override
  String get statsCompare => 'Compare';

  @override
  String statsSkillLevel(int level, int max) {
    return 'Lv $level / $max';
  }

  @override
  String get statsNoEquipment => 'Equip some gear to see your stats';

  @override
  String get skillDetailLevels => 'Levels';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String initError(Object error) {
    return 'Init error: $error';
  }

  @override
  String get syncUpdated => 'Game data updated';

  @override
  String get syncFailed => 'Sync failed — will retry when online';

  @override
  String get charmNew => 'New Charm';

  @override
  String get charmEdit => 'Edit Charm';

  @override
  String get charmSave => 'Save';

  @override
  String get charmDelete => 'Delete Charm';

  @override
  String get charmDeleteTitle => 'Delete Charm?';

  @override
  String charmDeleteMessage(String name) {
    return 'This will permanently delete \"$name\".';
  }

  @override
  String get charmDeleteConfirm => 'Delete';

  @override
  String get charmNameHint => 'Charm name';

  @override
  String get charmSkillNone => 'No skill';

  @override
  String get charmPickSkill => 'Select Skill';

  @override
  String get charmSectionSkills => 'Skills';

  @override
  String get charmSectionSlots => 'Slots';

  @override
  String get filterTitle => 'Filter & Sort';

  @override
  String get filterApply => 'Apply';

  @override
  String get filterReset => 'Reset';

  @override
  String get filterWeaponType => 'Weapon Type';

  @override
  String get filterElement => 'Element';

  @override
  String get filterAny => 'Any';

  @override
  String get filterNoElement => 'None';

  @override
  String get filterSortBy => 'Sort By';

  @override
  String get sortByName => 'Name';

  @override
  String get sortByAttack => 'Attack';

  @override
  String get sortByDefense => 'Defense';

  @override
  String get sortByRarity => 'Rarity';

  @override
  String get sortByNewest => 'Newest';

  @override
  String filterActiveCount(int count) {
    return '$count active';
  }

  @override
  String get compareSelectBuild => 'Compare with...';

  @override
  String get compareStop => 'Stop Comparing';

  @override
  String get compareVs => 'vs';
}
