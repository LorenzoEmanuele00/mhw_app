import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MHW Builder'**
  String get appTitle;

  /// No description provided for @navBuild.
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get navBuild;

  /// No description provided for @navEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get navEquipment;

  /// No description provided for @navStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get navStats;

  /// No description provided for @navLoadouts.
  ///
  /// In en, this message translates to:
  /// **'Loadouts'**
  String get navLoadouts;

  /// No description provided for @equipWeapons.
  ///
  /// In en, this message translates to:
  /// **'Weapons'**
  String get equipWeapons;

  /// No description provided for @equipArmor.
  ///
  /// In en, this message translates to:
  /// **'Armor'**
  String get equipArmor;

  /// No description provided for @equipCharm.
  ///
  /// In en, this message translates to:
  /// **'Charm'**
  String get equipCharm;

  /// No description provided for @armorSlotHead.
  ///
  /// In en, this message translates to:
  /// **'Head'**
  String get armorSlotHead;

  /// No description provided for @armorSlotChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get armorSlotChest;

  /// No description provided for @armorSlotArms.
  ///
  /// In en, this message translates to:
  /// **'Arms'**
  String get armorSlotArms;

  /// No description provided for @armorSlotWaist.
  ///
  /// In en, this message translates to:
  /// **'Waist'**
  String get armorSlotWaist;

  /// No description provided for @armorSlotLegs.
  ///
  /// In en, this message translates to:
  /// **'Legs'**
  String get armorSlotLegs;

  /// No description provided for @statAttack.
  ///
  /// In en, this message translates to:
  /// **'Attack'**
  String get statAttack;

  /// No description provided for @statDefense.
  ///
  /// In en, this message translates to:
  /// **'Defense'**
  String get statDefense;

  /// No description provided for @statAffinity.
  ///
  /// In en, this message translates to:
  /// **'Affinity'**
  String get statAffinity;

  /// No description provided for @statElement.
  ///
  /// In en, this message translates to:
  /// **'Element'**
  String get statElement;

  /// No description provided for @statSharpness.
  ///
  /// In en, this message translates to:
  /// **'Sharpness'**
  String get statSharpness;

  /// No description provided for @statRarity.
  ///
  /// In en, this message translates to:
  /// **'Rarity'**
  String get statRarity;

  /// No description provided for @elemFire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get elemFire;

  /// No description provided for @elemWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get elemWater;

  /// No description provided for @elemThunder.
  ///
  /// In en, this message translates to:
  /// **'Thunder'**
  String get elemThunder;

  /// No description provided for @elemIce.
  ///
  /// In en, this message translates to:
  /// **'Ice'**
  String get elemIce;

  /// No description provided for @elemDragon.
  ///
  /// In en, this message translates to:
  /// **'Dragon'**
  String get elemDragon;

  /// No description provided for @elemPoison.
  ///
  /// In en, this message translates to:
  /// **'Poison'**
  String get elemPoison;

  /// No description provided for @elemSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get elemSleep;

  /// No description provided for @elemParalysis.
  ///
  /// In en, this message translates to:
  /// **'Paralysis'**
  String get elemParalysis;

  /// No description provided for @elemBlast.
  ///
  /// In en, this message translates to:
  /// **'Blast'**
  String get elemBlast;

  /// No description provided for @resistFire.
  ///
  /// In en, this message translates to:
  /// **'Fire Res'**
  String get resistFire;

  /// No description provided for @resistWater.
  ///
  /// In en, this message translates to:
  /// **'Water Res'**
  String get resistWater;

  /// No description provided for @resistThunder.
  ///
  /// In en, this message translates to:
  /// **'Thunder Res'**
  String get resistThunder;

  /// No description provided for @resistIce.
  ///
  /// In en, this message translates to:
  /// **'Ice Res'**
  String get resistIce;

  /// No description provided for @resistDragon.
  ///
  /// In en, this message translates to:
  /// **'Dragon Res'**
  String get resistDragon;

  /// No description provided for @weaponTypeGs.
  ///
  /// In en, this message translates to:
  /// **'Greatsword'**
  String get weaponTypeGs;

  /// No description provided for @weaponTypeLs.
  ///
  /// In en, this message translates to:
  /// **'Longsword'**
  String get weaponTypeLs;

  /// No description provided for @weaponTypeSns.
  ///
  /// In en, this message translates to:
  /// **'Sword & Shield'**
  String get weaponTypeSns;

  /// No description provided for @weaponTypeDb.
  ///
  /// In en, this message translates to:
  /// **'Dual Blades'**
  String get weaponTypeDb;

  /// No description provided for @weaponTypeHmr.
  ///
  /// In en, this message translates to:
  /// **'Hammer'**
  String get weaponTypeHmr;

  /// No description provided for @weaponTypeHh.
  ///
  /// In en, this message translates to:
  /// **'Hunting Horn'**
  String get weaponTypeHh;

  /// No description provided for @weaponTypeLan.
  ///
  /// In en, this message translates to:
  /// **'Lance'**
  String get weaponTypeLan;

  /// No description provided for @weaponTypeGl.
  ///
  /// In en, this message translates to:
  /// **'Gunlance'**
  String get weaponTypeGl;

  /// No description provided for @weaponTypeSa.
  ///
  /// In en, this message translates to:
  /// **'Switch Axe'**
  String get weaponTypeSa;

  /// No description provided for @weaponTypeCb.
  ///
  /// In en, this message translates to:
  /// **'Charge Blade'**
  String get weaponTypeCb;

  /// No description provided for @weaponTypeIg.
  ///
  /// In en, this message translates to:
  /// **'Insect Glaive'**
  String get weaponTypeIg;

  /// No description provided for @weaponTypeLbg.
  ///
  /// In en, this message translates to:
  /// **'Light Bowgun'**
  String get weaponTypeLbg;

  /// No description provided for @weaponTypeHbg.
  ///
  /// In en, this message translates to:
  /// **'Heavy Bowgun'**
  String get weaponTypeHbg;

  /// No description provided for @weaponTypeBow.
  ///
  /// In en, this message translates to:
  /// **'Bow'**
  String get weaponTypeBow;

  /// No description provided for @sharpnessRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get sharpnessRed;

  /// No description provided for @sharpnessOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get sharpnessOrange;

  /// No description provided for @sharpnessYellow.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get sharpnessYellow;

  /// No description provided for @sharpnessGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get sharpnessGreen;

  /// No description provided for @sharpnessBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get sharpnessBlue;

  /// No description provided for @sharpnessWhite.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get sharpnessWhite;

  /// No description provided for @sharpnessPurple.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get sharpnessPurple;

  /// No description provided for @sectionSkills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get sectionSkills;

  /// No description provided for @sectionDecoSlots.
  ///
  /// In en, this message translates to:
  /// **'Decoration Slots'**
  String get sectionDecoSlots;

  /// No description provided for @sectionWeapon.
  ///
  /// In en, this message translates to:
  /// **'Weapon'**
  String get sectionWeapon;

  /// No description provided for @sectionArmor.
  ///
  /// In en, this message translates to:
  /// **'Armor'**
  String get sectionArmor;

  /// No description provided for @detailRarity.
  ///
  /// In en, this message translates to:
  /// **'R{n}'**
  String detailRarity(int n);

  /// No description provided for @detailSlot.
  ///
  /// In en, this message translates to:
  /// **'Slot {index} · Level {level}'**
  String detailSlot(int index, int level);

  /// No description provided for @charmSkillsOnly.
  ///
  /// In en, this message translates to:
  /// **'Charms grant skills only — no defense or resistances.'**
  String get charmSkillsOnly;

  /// No description provided for @catalogCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items in catalog'**
  String catalogCount(int count);

  /// No description provided for @searchEquipment.
  ///
  /// In en, this message translates to:
  /// **'Search equipment'**
  String get searchEquipment;

  /// No description provided for @searchJewels.
  ///
  /// In en, this message translates to:
  /// **'Search jewels'**
  String get searchJewels;

  /// No description provided for @filterButton.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterButton;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'Nothing matches \"{query}\".'**
  String searchNoResults(String query);

  /// No description provided for @buildSlotEmpty.
  ///
  /// In en, this message translates to:
  /// **'Empty slot'**
  String get buildSlotEmpty;

  /// No description provided for @buildNoWeapon.
  ///
  /// In en, this message translates to:
  /// **'No weapon equipped'**
  String get buildNoWeapon;

  /// No description provided for @buildActiveSkills.
  ///
  /// In en, this message translates to:
  /// **'Active Skills'**
  String get buildActiveSkills;

  /// No description provided for @buildNoSkills.
  ///
  /// In en, this message translates to:
  /// **'No skills active'**
  String get buildNoSkills;

  /// No description provided for @buildSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get buildSummary;

  /// No description provided for @slotPickerSelectWeapon.
  ///
  /// In en, this message translates to:
  /// **'Select Weapon'**
  String get slotPickerSelectWeapon;

  /// No description provided for @slotPickerSelectArmor.
  ///
  /// In en, this message translates to:
  /// **'Select {slot}'**
  String slotPickerSelectArmor(String slot);

  /// No description provided for @slotPickerSelectCharm.
  ///
  /// In en, this message translates to:
  /// **'Select Charm'**
  String get slotPickerSelectCharm;

  /// No description provided for @slotPickerClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get slotPickerClear;

  /// No description provided for @jewelPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Decoration'**
  String get jewelPickerTitle;

  /// No description provided for @jewelPickerSlotLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level} slot'**
  String jewelPickerSlotLevel(int level);

  /// No description provided for @jewelPickerAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get jewelPickerAvailable;

  /// No description provided for @jewelPickerTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Need a larger slot'**
  String get jewelPickerTooLarge;

  /// No description provided for @jewelPickerEmpty.
  ///
  /// In en, this message translates to:
  /// **'No slot selected'**
  String get jewelPickerEmpty;

  /// No description provided for @jewelSkillLabel.
  ///
  /// In en, this message translates to:
  /// **'Lv {level}'**
  String jewelSkillLabel(int level);

  /// No description provided for @equipTo.
  ///
  /// In en, this message translates to:
  /// **'Equip'**
  String get equipTo;

  /// No description provided for @equipChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get equipChange;

  /// No description provided for @equipped.
  ///
  /// In en, this message translates to:
  /// **'Equipped'**
  String get equipped;

  /// No description provided for @loadoutsNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get loadoutsNew;

  /// No description provided for @loadoutsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No builds yet'**
  String get loadoutsEmpty;

  /// No description provided for @loadoutsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Tap + New to create your first build.'**
  String get loadoutsEmptyHint;

  /// No description provided for @loadoutsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Build?'**
  String get loadoutsDeleteTitle;

  /// No description provided for @loadoutsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete \"{name}\".'**
  String loadoutsDeleteMessage(String name);

  /// No description provided for @loadoutsDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get loadoutsDeleteConfirm;

  /// No description provided for @loadoutsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get loadoutsCancel;

  /// No description provided for @loadoutsRenameTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename Build'**
  String get loadoutsRenameTitle;

  /// No description provided for @loadoutsRenameHint.
  ///
  /// In en, this message translates to:
  /// **'Build name'**
  String get loadoutsRenameHint;

  /// No description provided for @loadoutsRenameSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get loadoutsRenameSave;

  /// No description provided for @loadoutsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get loadoutsActive;

  /// No description provided for @loadoutsAtk.
  ///
  /// In en, this message translates to:
  /// **'ATK'**
  String get loadoutsAtk;

  /// No description provided for @loadoutsDef.
  ///
  /// In en, this message translates to:
  /// **'DEF'**
  String get loadoutsDef;

  /// No description provided for @statsResistances.
  ///
  /// In en, this message translates to:
  /// **'Resistances'**
  String get statsResistances;

  /// No description provided for @statsCompare.
  ///
  /// In en, this message translates to:
  /// **'Compare'**
  String get statsCompare;

  /// No description provided for @statsSkillLevel.
  ///
  /// In en, this message translates to:
  /// **'Lv {level} / {max}'**
  String statsSkillLevel(int level, int max);

  /// No description provided for @statsNoEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equip some gear to see your stats'**
  String get statsNoEquipment;

  /// No description provided for @skillDetailLevels.
  ///
  /// In en, this message translates to:
  /// **'Levels'**
  String get skillDetailLevels;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @initError.
  ///
  /// In en, this message translates to:
  /// **'Init error: {error}'**
  String initError(Object error);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
