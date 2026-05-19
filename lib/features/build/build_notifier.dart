import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database.dart';
import '../../core/database/tables/enums.dart';
import '../../shared/calc/build_stats.dart';
import '../../shared/calc/calc_engine.dart';
import '../../shared/calc/skills_repository.dart';
import 'repository/builds_repository.dart';
import '../equipment/armor/armor_repository.dart';
import '../equipment/jewels/jewels_repository.dart';
import '../equipment/talismans/talismans_repository.dart';
import '../equipment/weapons/weapons_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

@immutable
class BuildState {
  const BuildState({
    required this.build,
    this.weapon,
    this.head,
    this.chest,
    this.arms,
    this.waist,
    this.legs,
    this.talisman,
    this.jewels = const [],
    this.skills = const [],
    this.stats = BuildStats.empty,
  });

  final Build build;
  final Weapon? weapon;
  final ArmorPiece? head;
  final ArmorPiece? chest;
  final ArmorPiece? arms;
  final ArmorPiece? waist;
  final ArmorPiece? legs;
  final Talisman? talisman;
  final List<BuildJewel> jewels;
  final List<({Skill skill, int level})> skills;
  final BuildStats stats;

  ArmorPiece? pieceForSlot(ArmorSlotType slot) => switch (slot) {
        ArmorSlotType.head => head,
        ArmorSlotType.chest => chest,
        ArmorSlotType.arms => arms,
        ArmorSlotType.waist => waist,
        ArmorSlotType.legs => legs,
      };

  int? jewelIdForSlot(JewelSlotSource source, int slotIndex) {
    try {
      return jewels
          .firstWhere((j) => j.slotSource == source && j.slotIndex == slotIndex)
          .jewelId;
    } catch (_) {
      return null;
    }
  }

  int get totalDefense =>
      (head?.baseDefense ?? 0) +
      (chest?.baseDefense ?? 0) +
      (arms?.baseDefense ?? 0) +
      (waist?.baseDefense ?? 0) +
      (legs?.baseDefense ?? 0);
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

class ActiveBuildIdNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? id) => state = id;
}

final activeBuildIdProvider =
    NotifierProvider<ActiveBuildIdNotifier, int?>(ActiveBuildIdNotifier.new);

final buildNotifierProvider =
    NotifierProvider<BuildNotifier, AsyncValue<BuildState?>>(() => BuildNotifier());

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

class BuildNotifier extends Notifier<AsyncValue<BuildState?>> {
  int? _currentBuildId;

  @override
  AsyncValue<BuildState?> build() {
    ref.listen<int?>(activeBuildIdProvider, (prev, next) {
      // Skip if this build is already loaded
      if (next != null && next == _currentBuildId) return;
      _load(next);
    });
    _load(null);
    return const AsyncValue.loading();
  }

  Future<void> _load(int? id) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(buildsRepositoryProvider);
      Build? build;
      if (id != null) build = await repo.getById(id);

      if (build == null) {
        final all = await repo.watchAll().first;
        if (all.isEmpty) {
          final now = DateTime.now().millisecondsSinceEpoch;
          final newId = await repo.create(
            BuildsCompanion.insert(name: 'Build 1', createdAt: now, updatedAt: now),
          );
          build = await repo.getById(newId);
        } else {
          build = all.first;
        }
        // Resolve BEFORE updating activeBuildIdProvider so the listener
        // sees _currentBuildId already set and skips the redundant call.
        final resolved = await _resolve(build!);
        _currentBuildId = build.id;
        state = AsyncValue.data(resolved);
        ref.read(activeBuildIdProvider.notifier).set(build.id);
        return;
      }

      final resolved = await _resolve(build);
      _currentBuildId = build.id;
      state = AsyncValue.data(resolved);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<BuildState> _resolve(Build build) async {
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

    // Aggregate skills from armor pieces + talisman + jewels (no set bonuses — Phase 4)
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

    // Set bonus activation: count pieces per set → activate bonuses with enough pieces
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

    // Compute stats via CalcEngine
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

  Future<void> _persistBuild(BuildsCompanion companion) async {
    final repo = ref.read(buildsRepositoryProvider);
    await repo.update(companion);
    final build = await repo.getById(companion.id.value);
    if (build != null) {
      final resolved = await _resolve(build);
      _currentBuildId = build.id;
      state = AsyncValue.data(resolved);
    }
  }

  Future<void> _reloadCurrent() async {
    final id = state.asData?.value?.build.id;
    if (id == null) return;
    final build = await ref.read(buildsRepositoryProvider).getById(id);
    if (build != null) {
      state = AsyncValue.data(await _resolve(build));
    }
  }

  // ---------------------------------------------------------------------------
  // Equip / clear slots
  // ---------------------------------------------------------------------------

  Future<void> _clearJewelsForSource(JewelSlotSource source) async {
    final current = state.asData?.value;
    if (current == null) return;
    final remaining = current.jewels
        .where((j) => j.slotSource != source)
        .map((j) => BuildJewelsCompanion(
              buildId: Value(j.buildId),
              slotSource: Value(j.slotSource),
              slotIndex: Value(j.slotIndex),
              jewelId: Value(j.jewelId),
            ))
        .toList();
    await ref.read(buildsRepositoryProvider).replaceJewels(current.build.id, remaining);
  }

  Future<void> equipWeapon(int? weaponId) async {
    final current = state.asData?.value;
    if (current == null) return;
    if (weaponId != current.weapon?.id) {
      await _clearJewelsForSource(JewelSlotSource.weapon);
    }
    await _persistBuild(BuildsCompanion(
      id: Value(current.build.id),
      weaponId: Value(weaponId),
      updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    ));
  }

  Future<void> equipArmor(ArmorSlotType slot, int? pieceId) async {
    final current = state.asData?.value;
    if (current == null) return;
    final source = JewelSlotSource.values.byName(slot.name);
    if (pieceId != current.pieceForSlot(slot)?.id) {
      await _clearJewelsForSource(source);
    }
    final base = BuildsCompanion(
      id: Value(current.build.id),
      updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    );
    final companion = switch (slot) {
      ArmorSlotType.head  => base.copyWith(headId: Value(pieceId)),
      ArmorSlotType.chest => base.copyWith(chestId: Value(pieceId)),
      ArmorSlotType.arms  => base.copyWith(armsId: Value(pieceId)),
      ArmorSlotType.waist => base.copyWith(waistId: Value(pieceId)),
      ArmorSlotType.legs  => base.copyWith(legsId: Value(pieceId)),
    };
    await _persistBuild(companion);
  }

  Future<void> equipCharm(int? talismanId) async {
    final current = state.asData?.value;
    if (current == null) return;
    if (talismanId != current.talisman?.id) {
      await _clearJewelsForSource(JewelSlotSource.talisman);
    }
    await _persistBuild(BuildsCompanion(
      id: Value(current.build.id),
      talismanId: Value(talismanId),
      updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    ));
  }

  // ---------------------------------------------------------------------------
  // Jewel slots
  // ---------------------------------------------------------------------------

  Future<void> setJewel(JewelSlotSource source, int slotIndex, int jewelId) async {
    final current = state.asData?.value;
    if (current == null) return;
    final newRows = current.jewels
        .where((j) => !(j.slotSource == source && j.slotIndex == slotIndex))
        .map((j) => BuildJewelsCompanion(
              buildId: Value(j.buildId),
              slotSource: Value(j.slotSource),
              slotIndex: Value(j.slotIndex),
              jewelId: Value(j.jewelId),
            ))
        .toList()
      ..add(BuildJewelsCompanion.insert(
        buildId: current.build.id,
        slotSource: source,
        slotIndex: slotIndex,
        jewelId: jewelId,
      ));
    await ref.read(buildsRepositoryProvider).replaceJewels(current.build.id, newRows);
    await _reloadCurrent();
  }

  Future<void> clearJewel(JewelSlotSource source, int slotIndex) async {
    final current = state.asData?.value;
    if (current == null) return;
    final newRows = current.jewels
        .where((j) => !(j.slotSource == source && j.slotIndex == slotIndex))
        .map((j) => BuildJewelsCompanion(
              buildId: Value(j.buildId),
              slotSource: Value(j.slotSource),
              slotIndex: Value(j.slotIndex),
              jewelId: Value(j.jewelId),
            ))
        .toList();
    await ref.read(buildsRepositoryProvider).replaceJewels(current.build.id, newRows);
    await _reloadCurrent();
  }

  // ---------------------------------------------------------------------------
  // Loadouts management
  // ---------------------------------------------------------------------------

  Future<void> newBuild() async {
    final all = await ref.read(buildsRepositoryProvider).watchAll().first;
    final now = DateTime.now().millisecondsSinceEpoch;
    final name = 'Build ${all.length + 1}';
    final id = await ref.read(buildsRepositoryProvider).create(
          BuildsCompanion.insert(name: name, createdAt: now, updatedAt: now),
        );
    ref.read(activeBuildIdProvider.notifier).set(id);
  }

  Future<void> loadBuild(int id) async {
    ref.read(activeBuildIdProvider.notifier).set(id);
  }

  Future<void> renameBuild(int id, String name) async {
    await ref.read(buildsRepositoryProvider).update(
          BuildsCompanion(
            id: Value(id),
            name: Value(name),
            updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
          ),
        );
    if (state.asData?.value?.build.id == id) await _reloadCurrent();
  }

  Future<void> deleteBuild(int id) async {
    await ref.read(buildsRepositoryProvider).delete(id);
    if (state.asData?.value?.build.id == id) {
      _currentBuildId = null;
      ref.read(activeBuildIdProvider.notifier).set(null);
    }
  }
}
