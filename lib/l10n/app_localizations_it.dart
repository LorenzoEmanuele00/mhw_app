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
  String get navEquipment => 'Equipaggiamento';

  @override
  String get navBuilds => 'Build';

  @override
  String get navBuilder => 'Costruttore';

  @override
  String get screenWeapons => 'Armi';

  @override
  String get screenArmor => 'Armature';

  @override
  String get screenJewels => 'Gioielli';

  @override
  String get screenTalismans => 'Talismani';

  @override
  String get screenBuilds => 'Build';

  @override
  String get comingSoon => 'Prossimamente';

  @override
  String initError(Object error) {
    return 'Errore inizializzazione: $error';
  }
}
