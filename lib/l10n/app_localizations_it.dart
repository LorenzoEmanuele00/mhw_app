// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'MHW Builder';

  @override
  String get navBuild => 'Build';

  @override
  String get navEquipment => 'Equipaggiamento';

  @override
  String get navStats => 'Statistiche';

  @override
  String get navLoadouts => 'Loadout';

  @override
  String get equipWeapons => 'Armi';

  @override
  String get equipArmor => 'Armature';

  @override
  String get equipCharm => 'Talismani';

  @override
  String get armorSlotHead => 'Testa';

  @override
  String get armorSlotChest => 'Petto';

  @override
  String get armorSlotArms => 'Braccia';

  @override
  String get armorSlotWaist => 'Vita';

  @override
  String get armorSlotLegs => 'Gambe';

  @override
  String get statAttack => 'Attacco';

  @override
  String get statDefense => 'Difesa';

  @override
  String get statAffinity => 'Affinità';

  @override
  String get statElement => 'Elemento';

  @override
  String get statSharpness => 'Affilatura';

  @override
  String get statRarity => 'Rarità';

  @override
  String get elemFire => 'Fuoco';

  @override
  String get elemWater => 'Acqua';

  @override
  String get elemThunder => 'Tuono';

  @override
  String get elemIce => 'Ghiaccio';

  @override
  String get elemDragon => 'Drago';

  @override
  String get elemPoison => 'Veleno';

  @override
  String get elemSleep => 'Sonno';

  @override
  String get elemParalysis => 'Paralisi';

  @override
  String get elemBlast => 'Esplosione';

  @override
  String get resistFire => 'Res. Fuoco';

  @override
  String get resistWater => 'Res. Acqua';

  @override
  String get resistThunder => 'Res. Tuono';

  @override
  String get resistIce => 'Res. Ghiaccio';

  @override
  String get resistDragon => 'Res. Drago';

  @override
  String get weaponTypeGs => 'Spadone';

  @override
  String get weaponTypeLs => 'Nodachi';

  @override
  String get weaponTypeSns => 'Spada e Scudo';

  @override
  String get weaponTypeDb => 'Doppio Artiglio';

  @override
  String get weaponTypeHmr => 'Martello';

  @override
  String get weaponTypeHh => 'Corno Caccia';

  @override
  String get weaponTypeLan => 'Lancia';

  @override
  String get weaponTypeGl => 'Lancia Fucile';

  @override
  String get weaponTypeSa => 'Ascia Commutante';

  @override
  String get weaponTypeCb => 'Ascia da Carica';

  @override
  String get weaponTypeIg => 'Insettoglaive';

  @override
  String get weaponTypeLbg => 'Balistalite';

  @override
  String get weaponTypeHbg => 'Balistagrande';

  @override
  String get weaponTypeBow => 'Arco';

  @override
  String get sharpnessRed => 'Rosso';

  @override
  String get sharpnessOrange => 'Arancione';

  @override
  String get sharpnessYellow => 'Giallo';

  @override
  String get sharpnessGreen => 'Verde';

  @override
  String get sharpnessBlue => 'Blu';

  @override
  String get sharpnessWhite => 'Bianco';

  @override
  String get sharpnessPurple => 'Viola';

  @override
  String get sectionSkills => 'Abilità';

  @override
  String get sectionDecoSlots => 'Slot Decorazioni';

  @override
  String get sectionWeapon => 'Arma';

  @override
  String get sectionArmor => 'Armatura';

  @override
  String detailRarity(int n) {
    return 'R$n';
  }

  @override
  String detailSlot(int index, int level) {
    return 'Slot $index · Livello $level';
  }

  @override
  String get charmSkillsOnly =>
      'I talismani conferiscono solo abilità — nessuna difesa o resistenza.';

  @override
  String catalogCount(int count) {
    return '$count oggetti nel catalogo';
  }

  @override
  String get searchEquipment => 'Cerca equipaggiamento';

  @override
  String get searchJewels => 'Cerca gioielli';

  @override
  String get filterButton => 'Filtro';

  @override
  String searchNoResults(String query) {
    return 'Nessun risultato per \"$query\".';
  }

  @override
  String get comingSoon => 'Prossimamente';

  @override
  String initError(Object error) {
    return 'Errore di inizializzazione: $error';
  }
}
