import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/app_card.dart';
import '../../shared/widgets/large_title.dart';
import '../build/build_notifier.dart';
import '../builds/repository/builds_repository.dart';
import '../equipment/armor/repository/armor_repository.dart';
import '../equipment/weapons/repository/weapons_repository.dart';

class LoadoutsScreen extends ConsumerWidget {
  const LoadoutsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final buildsAsync = ref.watch(allBuildsProvider);
    final activeBuildId = ref.watch(buildNotifierProvider).asData?.value?.build.id;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LargeTitleBar(
            title: l10n.navLoadouts,
            trailing: HeaderAction(
              label: '+ ${l10n.loadoutsNew}',
              isPrimary: true,
              onTap: () => ref.read(buildNotifierProvider.notifier).newBuild(),
            ),
          ),

          Expanded(
            child: buildsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const SizedBox.shrink(),
              data: (builds) {
                if (builds.isEmpty) {
                  return _EmptyLoadouts(l10n: l10n, tokens: tokens);
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  itemCount: builds.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, idx) {
                    final build = builds[idx];
                    final isActive = build.id == activeBuildId;
                    return _SwipeableLoadoutCard(
                      loadout: build,
                      isActive: isActive,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty state
// ---------------------------------------------------------------------------

class _EmptyLoadouts extends StatelessWidget {
  const _EmptyLoadouts({required this.l10n, required this.tokens});
  final AppLocalizations l10n;
  final AppTokens tokens;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.loadoutsEmpty,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: tokens.label,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.loadoutsEmptyHint,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: tokens.label2),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Swipeable loadout card
// ---------------------------------------------------------------------------

class _SwipeableLoadoutCard extends ConsumerWidget {
  const _SwipeableLoadoutCard({
    required this.loadout,
    required this.isActive,
  });

  final Build loadout;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(loadout.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) {
            final l10n = AppLocalizations.of(ctx);
            return AlertDialog(
              title: Text(l10n.loadoutsDeleteTitle),
              content: Text(l10n.loadoutsDeleteMessage(loadout.name)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: Text(l10n.loadoutsCancel),
                ),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: Text(
                    l10n.loadoutsDeleteConfirm,
                    style: const TextStyle(color: AppColors.negativeRed),
                  ),
                ),
              ],
            );
          },
        ) ?? false;
      },
      onDismissed: (_) => ref.read(buildNotifierProvider.notifier).deleteBuild(loadout.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.negativeRed,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      child: _LoadoutCard(loadout: loadout, isActive: isActive),
    );
  }
}

// ---------------------------------------------------------------------------
// Loadout card
// ---------------------------------------------------------------------------

class _LoadoutCard extends ConsumerWidget {
  const _LoadoutCard({required this.loadout, required this.isActive});
  final Build loadout;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);

    // Resolve weapon + armor for mini stats (uses already-loaded provider data)
    final allWeapons = ref.watch(allWeaponsProvider).asData?.value ?? [];
    final allArmor = ref.watch(allArmorProvider).asData?.value ?? [];

    final weapon = allWeapons
        .where((w) => w.id == loadout.weaponId)
        .firstOrNull;
    final armorIds = [loadout.headId, loadout.chestId, loadout.armsId, loadout.waistId, loadout.legsId]
        .whereType<int>()
        .toList();
    final totalDef = allArmor
        .where((a) => armorIds.contains(a.id))
        .fold(0, (sum, a) => sum + a.baseDefense);

    // Slot filled indicators (7 slots: weapon + 5 armor + charm)
    final slotsFilled = [
      loadout.weaponId != null,
      loadout.headId != null,
      loadout.chestId != null,
      loadout.armsId != null,
      loadout.waistId != null,
      loadout.legsId != null,
      loadout.talismanId != null,
    ];

    return GestureDetector(
      onTap: () => ref.read(buildNotifierProvider.notifier).loadBuild(loadout.id),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            // Header row
            Row(
              children: [
                Expanded(
                  child: Text(
                    loadout.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                      color: tokens.label,
                    ),
                  ),
                ),
                if (isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: tokens.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      l10n.loadoutsActive,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: tokens.accent,
                      ),
                    ),
                  ),
              ],
            ),

            // Mini stats
            Row(
              spacing: 16,
              children: [
                _MiniStat(
                  label: l10n.loadoutsAtk,
                  value: weapon?.baseAttack.toString() ?? '—',
                  color: AppColors.negativeRed,
                ),
                _MiniStat(
                  label: l10n.loadoutsDef,
                  value: totalDef > 0 ? totalDef.toString() : '—',
                  color: tokens.accent,
                ),
                const Spacer(),
                // 7 slot dots
                Row(
                  spacing: 6,
                  children: slotsFilled.map((filled) {
                    return Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: filled ? tokens.accent : tokens.fill,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Action buttons
            Row(
              spacing: 8,
              children: [
                _CardAction(
                  label: l10n.loadoutsRenameTitle,
                  onTap: () => _showRenameDialog(context, ref),
                  color: tokens.label2,
                ),
                _CardAction(
                  label: l10n.loadoutsDeleteConfirm,
                  onTap: () => _showDeleteDialog(context, ref),
                  color: AppColors.negativeRed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showRenameDialog(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final ctrl = TextEditingController(text: loadout.name);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.loadoutsRenameTitle),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: InputDecoration(hintText: l10n.loadoutsRenameHint),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.loadoutsCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.loadoutsRenameSave),
          ),
        ],
      ),
    );
    if (confirmed == true && ctrl.text.trim().isNotEmpty) {
      ref.read(buildNotifierProvider.notifier).renameBuild(loadout.id, ctrl.text.trim());
    }
  }

  Future<void> _showDeleteDialog(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.loadoutsDeleteTitle),
        content: Text(l10n.loadoutsDeleteMessage(loadout.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.loadoutsCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.negativeRed),
            child: Text(l10n.loadoutsDeleteConfirm),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      ref.read(buildNotifierProvider.notifier).deleteBuild(loadout.id);
    }
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Row(
      spacing: 4,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: tokens.label2,
            letterSpacing: 0.3,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _CardAction extends StatelessWidget {
  const _CardAction({required this.label, required this.onTap, required this.color});
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: tokens.fill,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}
