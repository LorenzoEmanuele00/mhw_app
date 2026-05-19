import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database.dart';
import '../../core/database/tables/enums.dart';
import '../../shared/calc/build_resolver.dart';
import 'build_state.dart';
import 'repository/builds_repository.dart';

// Re-export BuildState so existing callers don't need to update their imports.
export 'build_state.dart';

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
        final resolved = await resolveBuild(build!, ref);
        _currentBuildId = build.id;
        state = AsyncValue.data(resolved);
        ref.read(activeBuildIdProvider.notifier).set(build.id);
        return;
      }

      final resolved = await resolveBuild(build, ref);
      _currentBuildId = build.id;
      state = AsyncValue.data(resolved);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> _persistBuild(BuildsCompanion companion) async {
    final repo = ref.read(buildsRepositoryProvider);
    await repo.update(companion);
    final build = await repo.getById(companion.id.value);
    if (build != null) {
      final resolved = await resolveBuild(build, ref);
      _currentBuildId = build.id;
      state = AsyncValue.data(resolved);
    }
  }

  Future<void> _reloadCurrent() async {
    final id = state.asData?.value?.build.id;
    if (id == null) return;
    final build = await ref.read(buildsRepositoryProvider).getById(id);
    if (build != null) {
      state = AsyncValue.data(await resolveBuild(build, ref));
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

  /// Reloads the currently active build from the database.
  /// Call this after mutating data (e.g. editing a talisman) that affects the active build.
  Future<void> refreshActiveBuild() => _reloadCurrent();

  Future<void> deleteBuild(int id) async {
    await ref.read(buildsRepositoryProvider).delete(id);
    if (state.asData?.value?.build.id == id) {
      _currentBuildId = null;
      ref.read(activeBuildIdProvider.notifier).set(null);
    }
  }
}
