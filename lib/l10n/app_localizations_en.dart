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
  String get navEquipment => 'Equipment';

  @override
  String get navBuilds => 'Builds';

  @override
  String get navBuilder => 'Builder';

  @override
  String get screenWeapons => 'Weapons';

  @override
  String get screenArmor => 'Armor';

  @override
  String get screenJewels => 'Jewels';

  @override
  String get screenTalismans => 'Talismans';

  @override
  String get screenBuilds => 'Builds';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String initError(Object error) {
    return 'Init error: $error';
  }
}
