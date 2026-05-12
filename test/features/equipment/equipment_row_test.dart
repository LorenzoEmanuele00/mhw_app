import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mhw_app/core/database/database.dart';
import 'package:mhw_app/core/database/tables/enums.dart';
import 'package:mhw_app/features/equipment/models/equip_item.dart';
import 'package:mhw_app/features/equipment/widgets/equipment_row.dart';
import 'package:mhw_app/l10n/app_localizations.dart';
import 'package:mhw_app/shared/theme/app_theme.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Widget _wrap(Widget child) => MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      theme: AppTheme.light(),
      home: Scaffold(body: child),
    );

Weapon _weapon({
  String name = 'Iron Sword',
  WeaponType type = WeaponType.gs,
  int attack = 220,
  double affinity = 0,
  String slots = '[]',
  ElementType? elementType,
  int? elementValue,
}) =>
    Weapon(
      id: 1,
      slug: 'iron_sword',
      name: name,
      weaponType: type,
      baseAttack: attack,
      baseAffinity: affinity,
      elementType: elementType,
      elementValue: elementValue,
      sharpnessMax: SharpnessLevel.white,
      rarity: 1,
      slots: slots,
      rmv: 4.8,
      emv: 1.0,
      damageType: DamageType.cut,
      burstGroup: 'Other',
    );

ArmorPiece _armorPiece({
  String name = 'Rathalos Helm',
  ArmorSlotType slotType = ArmorSlotType.head,
  int baseDefense = 40,
  String slots = '[]',
}) =>
    ArmorPiece(
      id: 1,
      slug: 'rathalos_helm',
      name: name,
      slotType: slotType,
      baseDefense: baseDefense,
      fireRes: 0,
      waterRes: 0,
      thunderRes: 0,
      iceRes: 0,
      dragonRes: 0,
      rarity: 5,
      slots: slots,
      setId: 1,
    );

Talisman _talisman({
  String name = 'Attack Charm',
  String slots = '[]',
}) =>
    Talisman(
      id: 1,
      name: name,
      slots: slots,
      createdAt: 0,
    );

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('EquipmentRow — weapon variant', () {
    testWidgets('shows weapon name and attack stat', (tester) async {
      final item = WeaponEquipItem(_weapon(name: 'Iron Sword', attack: 220));

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {})),
      );

      expect(find.text('Iron Sword'), findsOneWidget);
      expect(find.textContaining('220'), findsOneWidget);
      expect(find.textContaining('Attack'), findsOneWidget);
    });

    testWidgets('does not show weapon type label in row', (tester) async {
      final item = WeaponEquipItem(_weapon(type: WeaponType.ls));

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {})),
      );

      expect(find.textContaining('Longsword'), findsNothing);
    });

    testWidgets('shows affinity when non-zero', (tester) async {
      final item = WeaponEquipItem(_weapon(affinity: 15));

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {})),
      );

      expect(find.textContaining('+15'), findsOneWidget);
    });

    testWidgets('does not show affinity when zero', (tester) async {
      final item = WeaponEquipItem(_weapon(affinity: 0));

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {})),
      );

      expect(find.textContaining('%'), findsNothing);
    });

    testWidgets('shows element label when present', (tester) async {
      final item = WeaponEquipItem(
        _weapon(elementType: ElementType.fire, elementValue: 30),
      );

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {})),
      );

      expect(find.textContaining('Fire'), findsOneWidget);
    });

    testWidgets('shows Equipped badge when isEquipped', (tester) async {
      final item = WeaponEquipItem(_weapon());

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {}, isEquipped: true)),
      );

      expect(find.text('Equipped'), findsOneWidget);
    });

    testWidgets('no Equipped badge by default', (tester) async {
      final item = WeaponEquipItem(_weapon());

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {})),
      );

      expect(find.text('Equipped'), findsNothing);
    });

    testWidgets('onTap fires when tapped', (tester) async {
      var tapped = false;
      final item = WeaponEquipItem(_weapon());

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () => tapped = true)),
      );

      await tester.tap(find.byType(EquipmentRow));
      expect(tapped, isTrue);
    });
  });

  group('EquipmentRow — armor variant', () {
    testWidgets('shows armor name and defense stat', (tester) async {
      final item = ArmorEquipItem(_armorPiece(name: 'Rathalos Helm', baseDefense: 40));

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {})),
      );

      expect(find.text('Rathalos Helm'), findsOneWidget);
      expect(find.textContaining('40'), findsOneWidget);
      expect(find.textContaining('Defense'), findsOneWidget);
    });

    testWidgets('does not show slot type label in row', (tester) async {
      final item = ArmorEquipItem(_armorPiece(slotType: ArmorSlotType.chest));

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {})),
      );

      expect(find.textContaining('Chest'), findsNothing);
    });

    testWidgets('shows deco slots row for piece with slots', (tester) async {
      final item = ArmorEquipItem(_armorPiece(slots: '[2,1]'));

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {})),
      );

      expect(find.byType(EquipmentRow), findsOneWidget);
    });
  });

  group('EquipmentRow — charm variant', () {
    testWidgets('shows charm name and rarity label', (tester) async {
      final item = CharmEquipItem(_talisman(name: 'Attack Charm'));

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {})),
      );

      expect(find.text('Attack Charm'), findsOneWidget);
      expect(find.textContaining('Rarity'), findsOneWidget);
    });

    testWidgets('does not show type label for charm', (tester) async {
      final item = CharmEquipItem(_talisman());

      await tester.pumpWidget(
        _wrap(EquipmentRow(item: item, onTap: () {})),
      );

      // No weapon type or armor slot label
      expect(find.textContaining('Sword'), findsNothing);
      expect(find.textContaining('Head'), findsNothing);
    });
  });
}
