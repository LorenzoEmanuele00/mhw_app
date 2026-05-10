import 'package:flutter/material.dart';
import '../../core/database/tables/enums.dart';

// ---------------------------------------------------------------------------
// Design tokens — matches the prototype's THEMES / ACCENTS / color constants.
// Accessed via AppTokens.of(context) anywhere in the widget tree.
// ---------------------------------------------------------------------------

@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.bg,
    required this.card,
    required this.card2,
    required this.label,
    required this.label2,
    required this.label3,
    required this.sep,
    required this.fill,
    required this.chip,
    required this.barTrack,
    required this.tabBar,
    required this.accent,
  });

  final Color bg;
  final Color card;
  final Color card2;
  final Color label;
  final Color label2;
  final Color label3;
  final Color sep;
  final Color fill;
  final Color chip;
  final Color barTrack;
  final Color tabBar;
  final Color accent;

  static AppTokens of(BuildContext context) =>
      Theme.of(context).extension<AppTokens>()!;

  static const _light = AppTokens(
    bg: Color(0xFFF2F2F7),
    card: Color(0xFFFFFFFF),
    card2: Color(0xFFF2F2F7),
    label: Color(0xFF000000),
    label2: Color(0x993C3C43),
    label3: Color(0x4D3C3C43),
    sep: Color(0x1F3C3C43),
    fill: Color(0x29787880),
    chip: Color(0x1F787880),
    barTrack: Color(0x2E787880),
    tabBar: Color(0xC7F9F9F9),
    accent: Color(0xFF007AFF),
  );

  static const _dark = AppTokens(
    bg: Color(0xFF000000),
    card: Color(0xFF1C1C1E),
    card2: Color(0xFF2C2C2E),
    label: Color(0xFFFFFFFF),
    label2: Color(0x99EBEBF5),
    label3: Color(0x4DEBEBF5),
    sep: Color(0xA6545458),
    fill: Color(0x3D767680),
    chip: Color(0x52767680),
    barTrack: Color(0x52787880),
    tabBar: Color(0xC7161617),
    accent: Color(0xFF0A84FF),
  );

  @override
  AppTokens copyWith({
    Color? bg, Color? card, Color? card2,
    Color? label, Color? label2, Color? label3,
    Color? sep, Color? fill, Color? chip,
    Color? barTrack, Color? tabBar, Color? accent,
  }) => AppTokens(
    bg: bg ?? this.bg,
    card: card ?? this.card,
    card2: card2 ?? this.card2,
    label: label ?? this.label,
    label2: label2 ?? this.label2,
    label3: label3 ?? this.label3,
    sep: sep ?? this.sep,
    fill: fill ?? this.fill,
    chip: chip ?? this.chip,
    barTrack: barTrack ?? this.barTrack,
    tabBar: tabBar ?? this.tabBar,
    accent: accent ?? this.accent,
  );

  @override
  AppTokens lerp(AppTokens other, double t) => AppTokens(
    bg: Color.lerp(bg, other.bg, t)!,
    card: Color.lerp(card, other.card, t)!,
    card2: Color.lerp(card2, other.card2, t)!,
    label: Color.lerp(label, other.label, t)!,
    label2: Color.lerp(label2, other.label2, t)!,
    label3: Color.lerp(label3, other.label3, t)!,
    sep: Color.lerp(sep, other.sep, t)!,
    fill: Color.lerp(fill, other.fill, t)!,
    chip: Color.lerp(chip, other.chip, t)!,
    barTrack: Color.lerp(barTrack, other.barTrack, t)!,
    tabBar: Color.lerp(tabBar, other.tabBar, t)!,
    accent: Color.lerp(accent, other.accent, t)!,
  );
}

// ---------------------------------------------------------------------------
// Semantic color helpers — element, skill category, sharpness.
// ---------------------------------------------------------------------------

abstract final class AppColors {
  static Color element(ElementType type, Brightness b) {
    const light = <ElementType, Color>{
      ElementType.fire:      Color(0xFFFF6A3D),
      ElementType.water:     Color(0xFF0A84FF),
      ElementType.thunder:   Color(0xFFE0A100),
      ElementType.ice:       Color(0xFF5AC8FA),
      ElementType.dragon:    Color(0xFF7A5AE0),
      ElementType.poison:    Color(0xFF30D158),
      ElementType.sleep:     Color(0xFF64D2FF),
      ElementType.paralysis: Color(0xFFFFD60A),
      ElementType.blast:     Color(0xFFFF9F0A),
    };
    const dark = <ElementType, Color>{
      ElementType.fire:      Color(0xFFFF7A55),
      ElementType.water:     Color(0xFF3098FF),
      ElementType.thunder:   Color(0xFFFFCC00),
      ElementType.ice:       Color(0xFF64D2FF),
      ElementType.dragon:    Color(0xFF9D7FF0),
      ElementType.poison:    Color(0xFF30D158),
      ElementType.sleep:     Color(0xFF64D2FF),
      ElementType.paralysis: Color(0xFFFFD60A),
      ElementType.blast:     Color(0xFFFF9F0A),
    };
    return (b == Brightness.light ? light : dark)[type] ?? const Color(0xFF8E8E93);
  }

  static Color skillCategory(SkillSubcategory sub, Brightness b) {
    const light = <SkillSubcategory, Color>{
      SkillSubcategory.offensive: Color(0xFFFF3B30),
      SkillSubcategory.technical: Color(0xFFFF9500),
      SkillSubcategory.regen:     Color(0xFF34C759),
      SkillSubcategory.defensive: Color(0xFF007AFF),
      SkillSubcategory.utility:   Color(0xFF8E8E93),
      SkillSubcategory.farming:   Color(0xFFAF52DE),
    };
    const dark = <SkillSubcategory, Color>{
      SkillSubcategory.offensive: Color(0xFFFF453A),
      SkillSubcategory.technical: Color(0xFFFF9F0A),
      SkillSubcategory.regen:     Color(0xFF30D158),
      SkillSubcategory.defensive: Color(0xFF0A84FF),
      SkillSubcategory.utility:   Color(0xFF98989D),
      SkillSubcategory.farming:   Color(0xFFBF5AF2),
    };
    return (b == Brightness.light ? light : dark)[sub] ?? const Color(0xFF8E8E93);
  }

  static Color sharpness(SharpnessLevel level) {
    const colors = <SharpnessLevel, Color>{
      SharpnessLevel.red:    Color(0xFFFF453A),
      SharpnessLevel.orange: Color(0xFFFF9F0A),
      SharpnessLevel.yellow: Color(0xFFFFD60A),
      SharpnessLevel.green:  Color(0xFF30D158),
      SharpnessLevel.blue:   Color(0xFF0A84FF),
      SharpnessLevel.white:  Color(0xFFF2F2F7),
      SharpnessLevel.purple: Color(0xFFBF5AF2),
    };
    return colors[level]!;
  }

  static const negativeRed = Color(0xFFFF453A);
}

// ---------------------------------------------------------------------------
// ThemeData factories
// ---------------------------------------------------------------------------

abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light, AppTokens._light);
  static ThemeData dark() => _build(Brightness.dark, AppTokens._dark);

  static ThemeData _build(Brightness brightness, AppTokens tokens) {
    final cs = ColorScheme.fromSeed(
      seedColor: tokens.accent,
      brightness: brightness,
    ).copyWith(
      surface: tokens.card,
      surfaceContainerLowest: tokens.bg,
      primary: tokens.accent,
    );

    return ThemeData(
      colorScheme: cs,
      useMaterial3: true,
      scaffoldBackgroundColor: tokens.bg,
      extensions: [tokens],
      // NavigationBar styling
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: tokens.tabBar,
        indicatorColor: tokens.accent.withValues(alpha: 0.15),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final active = states.contains(WidgetState.selected);
          return IconThemeData(color: active ? tokens.accent : tokens.label2);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final active = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: active ? tokens.accent : tokens.label2,
          );
        }),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      // NavigationRail for landscape
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: tokens.card,
        selectedIconTheme: IconThemeData(color: tokens.accent),
        unselectedIconTheme: IconThemeData(color: tokens.label2),
        selectedLabelTextStyle: TextStyle(color: tokens.accent, fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelTextStyle: TextStyle(color: tokens.label2, fontSize: 12),
        indicatorColor: tokens.accent.withValues(alpha: 0.15),
        elevation: 0,
      ),
      dividerTheme: DividerThemeData(color: tokens.sep, space: 0, thickness: 0.5),
      textTheme: const TextTheme().apply(
        bodyColor: tokens.label,
        displayColor: tokens.label,
      ),
    );
  }
}
