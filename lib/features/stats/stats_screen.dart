import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database.dart';
import '../../core/database/tables/enums.dart';
import '../../features/build/build_notifier.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/calc/build_stats.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/utils/label_helpers.dart';
import '../../shared/utils/slots_parser.dart';
import '../../shared/widgets/app_card.dart';
import '../../shared/widgets/app_sheet.dart';
import '../../shared/widgets/skill_detail_sheet.dart';
import '../../shared/widgets/deco_slots_row.dart';
import '../../shared/widgets/large_title.dart';
import '../../shared/widgets/section_label.dart';
import '../../shared/widgets/sharpness_gauge.dart';
import '../../shared/widgets/stat_bar.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  bool _showRadar = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final buildAsync = ref.watch(buildNotifierProvider);

    return SafeArea(
      child: buildAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(l10n.initError(e), style: TextStyle(color: tokens.label2)),
        ),
        data: (buildState) {
          if (buildState == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return _StatsContent(
            buildState: buildState,
            showRadar: _showRadar,
            onToggleResistView: () => setState(() => _showRadar = !_showRadar),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Main scrollable content
// ---------------------------------------------------------------------------

class _StatsContent extends StatelessWidget {
  const _StatsContent({
    required this.buildState,
    required this.showRadar,
    required this.onToggleResistView,
  });

  final BuildState buildState;
  final bool showRadar;
  final VoidCallback onToggleResistView;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final stats = buildState.stats;
    final hasWeapon = buildState.weapon != null;

    // Aggregate all deco slots across the full build
    final allSlots = <int>[];
    for (final src in [
      buildState.weapon?.slots,
      buildState.head?.slots,
      buildState.chest?.slots,
      buildState.arms?.slots,
      buildState.waist?.slots,
      buildState.legs?.slots,
    ]) {
      if (src != null) allSlots.addAll(parseSlots(src));
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: LargeTitleBar(
            title: l10n.navStats,
            subtitle: buildState.build.name,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Headline 2×2 card
              _HeadlineCard(stats: stats, buildState: buildState),
              const SizedBox(height: 28),

              // Sharpness
              if (hasWeapon) ...[
                SectionLabel(text: l10n.statSharpness),
                _SharpnessCard(stats: stats),
                const SizedBox(height: 28),
              ],

              // Elemental Resistances
              SectionLabel(
                text: l10n.statsResistances,
                trailing: GestureDetector(
                  onTap: onToggleResistView,
                  child: _TogglePill(
                    left: 'Radar',
                    right: 'Bars',
                    isLeft: showRadar,
                  ),
                ),
              ),
              _ResistancesCard(
                stats: stats,
                showRadar: showRadar,
              ),
              const SizedBox(height: 28),

              // Skills
              SectionLabel(text: l10n.sectionSkills),
              if (buildState.skills.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    l10n.buildNoSkills,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTokens.of(context).label2,
                    ),
                  ),
                )
              else
                AppCard(
                  padding: 0,
                  child: Column(
                    children: [
                      for (int i = 0; i < buildState.skills.length; i++) ...[
                        if (i > 0)
                          Divider(
                            height: 0,
                            indent: 16,
                            endIndent: 0,
                            color: AppTokens.of(context).sep,
                          ),
                        _SkillRow(
                          entry: buildState.skills[i],
                          onTap: () => showAppSheet(
                            context: context,
                            child: SkillDetailSheet(
                              skill: buildState.skills[i].skill,
                              currentLevel: buildState.skills[i].level,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              const SizedBox(height: 28),

              // Decoration Slots summary
              if (allSlots.isNotEmpty) ...[
                SectionLabel(text: l10n.sectionDecoSlots),
                AppCard(
                  child: DecoSlotsRow(slots: allSlots..sort((a, b) => b.compareTo(a))),
                ),
                const SizedBox(height: 28),
              ],

              // Compare button (Phase 6 placeholder)
              OutlinedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(l10n.statsCompare),
                    content: Text(l10n.comingSoon),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(l10n.loadoutsCancel),
                      ),
                    ],
                  ),
                ),
                child: Text(l10n.statsCompare),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Headline 2×2 grid
// ---------------------------------------------------------------------------

class _HeadlineCard extends StatelessWidget {
  const _HeadlineCard({required this.stats, required this.buildState});
  final BuildStats stats;
  final BuildState buildState;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final brightness = Theme.of(context).brightness;
    final hasWeapon = buildState.weapon != null;

    final affinity = stats.effectiveAffinity;
    final affStr = hasWeapon
        ? '${affinity >= 0 ? '+' : ''}${affinity.toStringAsFixed(0)}%'
        : '—';

    String elemStr = '—';
    Color elemColor = tokens.label2;
    if (hasWeapon && buildState.weapon?.elementType != null && stats.trueElement > 0) {
      elemStr = stats.trueElement.toStringAsFixed(1);
      elemColor = AppColors.element(buildState.weapon!.elementType!, brightness);
    }

    return AppCard(
      child: Row(
        children: [
          _HeadlineCell(
            label: l10n.statAttack,
            value: hasWeapon ? stats.trueRaw.round().toString() : '—',
            color: AppColors.negativeRed,
          ),
          _HeadlineDivider(),
          _HeadlineCell(
            label: l10n.statDefense,
            value: stats.totalDefense > 0 ? stats.totalDefense.toString() : '—',
            color: tokens.accent,
          ),
          _HeadlineDivider(),
          _HeadlineCell(
            label: l10n.statAffinity,
            value: affStr,
            color: const Color(0xFFFF9F0A),
          ),
          _HeadlineDivider(),
          _HeadlineCell(
            label: buildState.weapon?.elementType != null
                ? elementLabel(buildState.weapon!.elementType!, l10n)
                : l10n.statElement,
            value: elemStr,
            color: elemColor,
          ),
        ],
      ),
    );
  }
}

class _HeadlineCell extends StatelessWidget {
  const _HeadlineCell({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: tokens.label2,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeadlineDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Container(width: 0.5, height: 36, color: tokens.sep);
  }
}

// ---------------------------------------------------------------------------
// Sharpness card
// ---------------------------------------------------------------------------

class _SharpnessCard extends StatelessWidget {
  const _SharpnessCard({required this.stats});
  final BuildStats stats;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final sharpness = stats.effectiveSharpness;
    final sharpColor = AppColors.sharpness(sharpness);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _sharpnessLabel(sharpness, AppLocalizations.of(context)),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: sharpColor,
                  letterSpacing: -0.2,
                ),
              ),
              Text(
                '×${stats.sharpnessRawMod.toStringAsFixed(2)} raw  '
                '×${stats.sharpnessElemMod.toStringAsFixed(4)} elem',
                style: TextStyle(fontSize: 12, color: tokens.label2),
              ),
            ],
          ),
          SharpnessGauge(sharpnessMax: sharpness),
        ],
      ),
    );
  }

  static String _sharpnessLabel(SharpnessLevel s, AppLocalizations l10n) =>
      switch (s) {
        SharpnessLevel.red    => l10n.sharpnessRed,
        SharpnessLevel.orange => l10n.sharpnessOrange,
        SharpnessLevel.yellow => l10n.sharpnessYellow,
        SharpnessLevel.green  => l10n.sharpnessGreen,
        SharpnessLevel.blue   => l10n.sharpnessBlue,
        SharpnessLevel.white  => l10n.sharpnessWhite,
        SharpnessLevel.purple => l10n.sharpnessPurple,
      };
}

// ---------------------------------------------------------------------------
// Resistances (Radar / Bars toggle)
// ---------------------------------------------------------------------------

class _ResistancesCard extends StatelessWidget {
  const _ResistancesCard({required this.stats, required this.showRadar});
  final BuildStats stats;
  final bool showRadar;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brightness = Theme.of(context).brightness;

    final entries = [
      (ElementType.fire,    stats.fireRes,    l10n.resistFire),
      (ElementType.water,   stats.waterRes,   l10n.resistWater),
      (ElementType.thunder, stats.thunderRes, l10n.resistThunder),
      (ElementType.ice,     stats.iceRes,     l10n.resistIce),
      (ElementType.dragon,  stats.dragonRes,  l10n.resistDragon),
    ];

    return AppCard(
      child: showRadar
          ? SizedBox(
              height: 200,
              child: _ResistanceRadar(entries: entries, brightness: brightness),
            )
          : Column(
              spacing: 14,
              children: entries.map((e) {
                final (elemType, value, label) = e;
                return StatBar(
                  label: label,
                  value: value,
                  max: 50,
                  color: AppColors.element(elemType, brightness),
                  signed: true,
                );
              }).toList(),
            ),
    );
  }
}

// ---------------------------------------------------------------------------
// Radar chart (pentagon) for elemental resistances
// ---------------------------------------------------------------------------

class _ResistanceRadar extends StatelessWidget {
  const _ResistanceRadar({
    required this.entries,
    required this.brightness,
  });

  final List<(ElementType, int, String)> entries;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadarPainter(entries: entries, brightness: brightness),
    );
  }
}

class _RadarPainter extends CustomPainter {
  const _RadarPainter({required this.entries, required this.brightness});

  final List<(ElementType, int, String)> entries;
  final Brightness brightness;

  static const int _sides = 5;
  static const double _minVal = -50.0;
  static const double _maxVal = 50.0;
  static const double _range = _maxVal - _minVal;

  // Label padding outward from the vertex
  static const double _labelPad = 22.0;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = math.min(cx, cy) - _labelPad - 12;

    final gridPaint = Paint()
      ..color = (brightness == Brightness.dark
              ? const Color(0xFFFFFFFF)
              : const Color(0xFF000000))
          .withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final axisPaint = Paint()
      ..color = (brightness == Brightness.dark
              ? const Color(0xFFFFFFFF)
              : const Color(0xFF000000))
          .withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw grid rings (at 25%, 50%, 75%, 100% of max positive range)
    for (final frac in [0.25, 0.5, 0.75, 1.0]) {
      final r = radius * frac;
      final path = Path();
      for (int i = 0; i < _sides; i++) {
        final angle = _vertexAngle(i);
        final x = cx + r * math.cos(angle);
        final y = cy + r * math.sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // Zero circle (small dot at center for reference)
    canvas.drawCircle(Offset(cx, cy), 2, axisPaint);

    // Draw axis lines
    for (int i = 0; i < _sides; i++) {
      final angle = _vertexAngle(i);
      canvas.drawLine(
        Offset(cx, cy),
        Offset(cx + radius * math.cos(angle), cy + radius * math.sin(angle)),
        axisPaint,
      );
    }

    // Draw data polygon
    final dataPath = Path();
    for (int i = 0; i < _sides; i++) {
      final value = entries[i].$2.toDouble().clamp(_minVal, _maxVal);
      // Map value to radius: 0 → center, +maxVal → full radius
      final normalised = (value - _minVal) / _range; // 0..1
      final r = normalised * radius;
      final angle = _vertexAngle(i);
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();

    final fillPaint = Paint()
      ..color = const Color(0xFF0A84FF).withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = const Color(0xFF0A84FF).withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(dataPath, fillPaint);
    canvas.drawPath(dataPath, strokePaint);

    // Vertex dots + labels
    for (int i = 0; i < _sides; i++) {
      final (elemType, value, label) = entries[i];
      final angle = _vertexAngle(i);
      final elemColor = AppColors.element(elemType, brightness);

      // Dot at vertex
      canvas.drawCircle(
        Offset(cx + radius * math.cos(angle), cy + radius * math.sin(angle)),
        3,
        Paint()..color = elemColor,
      );

      // Label
      final labelOffset = _labelPad + 4;
      final lx = cx + (radius + labelOffset) * math.cos(angle);
      final ly = cy + (radius + labelOffset) * math.sin(angle);

      final signedStr = value >= 0 ? '+$value' : '$value';
      final textPainter = TextPainter(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label\n',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.6)
                    : Colors.black.withValues(alpha: 0.5),
              ),
            ),
            TextSpan(
              text: signedStr,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: elemColor,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 60);
      textPainter.paint(
        canvas,
        Offset(lx - textPainter.width / 2, ly - textPainter.height / 2),
      );
    }
  }

  // Angle of vertex i in a regular pentagon, starting from top (-π/2)
  static double _vertexAngle(int i) =>
      -math.pi / 2 + 2 * math.pi * i / _sides;

  @override
  bool shouldRepaint(_RadarPainter old) =>
      old.entries != entries || old.brightness != brightness;
}

// ---------------------------------------------------------------------------
// Toggle pill widget (Radar | Bars)
// ---------------------------------------------------------------------------

class _TogglePill extends StatelessWidget {
  const _TogglePill({
    required this.left,
    required this.right,
    required this.isLeft,
  });
  final String left;
  final String right;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: tokens.fill,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Pill(label: left, active: isLeft),
          _Pill(label: right, active: !isLeft),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.active});
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: active ? tokens.card : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        boxShadow: active
            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 4)]
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: active ? tokens.label : tokens.label2,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Skill row with pip progress bar
// ---------------------------------------------------------------------------

class _SkillRow extends StatelessWidget {
  const _SkillRow({required this.entry, this.onTap});
  final ({Skill skill, int level}) entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final brightness = Theme.of(context).brightness;
    final skill = entry.skill;
    final color = AppColors.skillCategory(skill.type2, brightness);

    return InkWell(
      onTap: onTap,
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        spacing: 12,
        children: [
          // Colored dot
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      skill.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: tokens.label,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        l10n.statsSkillLevel(entry.level, skill.maxLevel),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: color,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                // Pip progress bar
                _SkillPips(
                  level: entry.level,
                  maxLevel: skill.maxLevel,
                  color: color,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }
}

class _SkillPips extends StatelessWidget {
  const _SkillPips({
    required this.level,
    required this.maxLevel,
    required this.color,
  });
  final int level;
  final int maxLevel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final count = maxLevel.clamp(1, 10);

    return Row(
      spacing: 4,
      children: List.generate(count, (i) {
        final filled = i < level;
        return Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: filled ? color : tokens.barTrack,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
