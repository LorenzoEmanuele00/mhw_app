import 'package:flutter/foundation.dart';
import '../../core/database/tables/enums.dart';

@immutable
class BuildStats {
  const BuildStats({
    required this.trueRaw,
    required this.effectiveAffinity,
    required this.trueElement,
    this.elementType,
    required this.effectiveSharpness,
    required this.sharpnessRawMod,
    required this.sharpnessElemMod,
    required this.totalDefense,
    required this.fireRes,
    required this.waterRes,
    required this.thunderRes,
    required this.iceRes,
    required this.dragonRes,
  });

  /// Calculated true raw (base × multipliers + additives).
  final double trueRaw;

  /// Effective affinity as percentage points (e.g. 25.0 = 25%).
  final double effectiveAffinity;

  /// Calculated true element (base × 0.1 × multipliers + additives).
  final double trueElement;
  final ElementType? elementType;

  final SharpnessLevel effectiveSharpness;
  final double sharpnessRawMod;
  final double sharpnessElemMod;

  final int totalDefense;
  final int fireRes;
  final int waterRes;
  final int thunderRes;
  final int iceRes;
  final int dragonRes;

  static const empty = BuildStats(
    trueRaw: 0,
    effectiveAffinity: 0,
    trueElement: 0,
    effectiveSharpness: SharpnessLevel.white,
    sharpnessRawMod: 1.32,
    sharpnessElemMod: 1.15,
    totalDefense: 0,
    fireRes: 0,
    waterRes: 0,
    thunderRes: 0,
    iceRes: 0,
    dragonRes: 0,
  );
}
