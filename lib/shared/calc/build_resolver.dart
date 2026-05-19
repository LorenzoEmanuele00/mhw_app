import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database.dart';
import 'calc_engine.dart';
import 'skills_repository.dart';
import '../../features/build/build_state.dart';
import '../../features/build/repository/builds_repository.dart';
import '../../features/equipment/armor/armor_repository.dart';
import '../../features/equipment/jewels/jewels_repository.dart';
import '../../features/equipment/talismans/talismans_repository.dart';
import '../../features/equipment/weapons/weapons_repository.dart';

/// Resolves a persisted [Build] into a full [BuildState] by loading all
/// referenced equipment and computing stats via [CalcEngine].
Future<BuildState> resolveBuild(Build build, Ref ref) async {
  final weaponsRepo = ref.read(weaponsRepositoryProvider);
  final armorRepo = ref.read(armorRepositoryProvider);
  final talismansRepo = ref.read(talismansRepositoryProvider);
  final buildsRepo = ref.read(buildsRepositoryProvider);

  final (weapon, head, chest, arms, waist, legs, talisman, jewels) = await (
    build.weaponId != null
        ? weaponsRepo.getById(build.weaponId!)
        : Future<Weapon?>.value(null),
    build.headId != null
        ? armorRepo.getById(build.headId!)
        : Future<ArmorPiece?>.value(null),
    build.chestId != null
        ? armorRepo.getById(build.chestId!)
        : Future<ArmorPiece?>.value(null),
    build.armsId != null
        ? armorRepo.getById(build.armsId!)
        : Future<ArmorPiece?>.value(null),
    build.waistId != null
        ? armorRepo.getById(build.waistId!)
        : Future<ArmorPiece?>.value(null),
    build.legsId != null
        ? armorRepo.getById(build.legsId!)
        : Future<ArmorPiece?>.value(null),
    build.talismanId != null
        ? talismansRepo.getById(build.talismanId!)
        : Future<Talisman?>.value(null),
    buildsRepo.getJewels(build.id),
  ).wait;

  final skillMap = <int, ({Skill skill, int level})>{};

  void addSkill(Skill skill, int addedLevel) {
    final existing = skillMap[skill.id];
    if (existing == null) {
      skillMap[skill.id] = (skill: skill, level: addedLevel);
    } else {
      final capped = (existing.level + addedLevel).clamp(0, skill.maxLevel);
      skillMap[skill.id] = (skill: skill, level: capped);
    }
  }

  await Future.wait([
    for (final piece in [head, chest, arms, waist, legs].whereType<ArmorPiece>())
      armorRepo.getPieceSkills(piece.id).then((list) {
        for (final e in list) {
          addSkill(e.skill, e.level);
        }
      }),
  ]);

  final skillsRepo = ref.read(skillsRepositoryProvider);

  if (talisman != null) {
    for (final (skillId, level) in [
      (talisman.skill1Id, talisman.skill1Level),
      (talisman.skill2Id, talisman.skill2Level),
    ]) {
      if (skillId != null && level != null) {
        final skill = await skillsRepo.getById(skillId);
        if (skill != null) addSkill(skill, level);
      }
    }
  }

  if (jewels.isNotEmpty) {
    final allJewelSkills = await ref.read(jewelsRepositoryProvider).getAllJewelSkills();
    final jewelSkillsByJewelId = <int, List<JewelSkill>>{};
    for (final js in allJewelSkills) {
      jewelSkillsByJewelId.putIfAbsent(js.jewelId, () => []).add(js);
    }
    for (final buildJewel in jewels) {
      for (final js in jewelSkillsByJewelId[buildJewel.jewelId] ?? []) {
        final skill = await skillsRepo.getById(js.skillId);
        if (skill != null) addSkill(skill, js.skillLevel);
      }
    }
  }

  final setPieceCounts = <int, int>{};
  for (final piece in [head, chest, arms, waist, legs].whereType<ArmorPiece>()) {
    setPieceCounts[piece.setId] = (setPieceCounts[piece.setId] ?? 0) + 1;
  }
  if (setPieceCounts.isNotEmpty) {
    final setSkills = await armorRepo.getSetSkillsForSets(setPieceCounts.keys.toList());
    for (final ss in setSkills) {
      final count = setPieceCounts[ss.setId] ?? 0;
      if (count >= ss.requiredPieces) {
        final existing = skillMap[ss.skillId];
        if (existing == null || ss.skillLevel > existing.level) {
          final skillObj = await skillsRepo.getById(ss.skillId);
          if (skillObj != null) {
            skillMap[ss.skillId] = (skill: skillObj, level: ss.skillLevel);
          }
        }
      }
    }
  }

  final skills = skillMap.values.toList()
    ..sort((a, b) => b.level.compareTo(a.level));

  final allSkillLevels = await skillsRepo.getAllSkillLevels();
  final skillLevelsById = <int, List<SkillLevel>>{};
  for (final sl in allSkillLevels) {
    skillLevelsById.putIfAbsent(sl.skillId, () => []).add(sl);
  }
  final stats = CalcEngine.compute(
    weapon: weapon,
    armorPieces: [head, chest, arms, waist, legs],
    activeSkills: skills,
    skillLevelsById: skillLevelsById,
  );

  return BuildState(
    build: build,
    weapon: weapon,
    head: head,
    chest: chest,
    arms: arms,
    waist: waist,
    legs: legs,
    talisman: talisman,
    jewels: jewels,
    skills: skills,
    stats: stats,
  );
}
