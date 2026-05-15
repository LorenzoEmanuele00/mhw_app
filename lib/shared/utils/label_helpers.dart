import '../../core/database/tables/enums.dart';
import '../../l10n/app_localizations.dart';

String weaponTypeLabel(WeaponType type, AppLocalizations l10n) => switch (type) {
      WeaponType.gs  => l10n.weaponTypeGs,
      WeaponType.ls  => l10n.weaponTypeLs,
      WeaponType.sns => l10n.weaponTypeSns,
      WeaponType.db  => l10n.weaponTypeDb,
      WeaponType.hmr => l10n.weaponTypeHmr,
      WeaponType.hh  => l10n.weaponTypeHh,
      WeaponType.lan => l10n.weaponTypeLan,
      WeaponType.gl  => l10n.weaponTypeGl,
      WeaponType.sa  => l10n.weaponTypeSa,
      WeaponType.cb  => l10n.weaponTypeCb,
      WeaponType.ig  => l10n.weaponTypeIg,
      WeaponType.lbg => l10n.weaponTypeLbg,
      WeaponType.hbg => l10n.weaponTypeHbg,
      WeaponType.bow => l10n.weaponTypeBow,
    };

String elementLabel(ElementType type, AppLocalizations l10n) => switch (type) {
      ElementType.fire      => l10n.elemFire,
      ElementType.water     => l10n.elemWater,
      ElementType.thunder   => l10n.elemThunder,
      ElementType.ice       => l10n.elemIce,
      ElementType.dragon    => l10n.elemDragon,
      ElementType.poison    => l10n.elemPoison,
      ElementType.sleep     => l10n.elemSleep,
      ElementType.paralysis => l10n.elemParalysis,
      ElementType.blast     => l10n.elemBlast,
    };
