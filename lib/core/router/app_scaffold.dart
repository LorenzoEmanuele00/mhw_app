import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/theme/app_theme.dart';

/// Adaptive scaffold: shows a [NavigationBar] in portrait/narrow mode and a
/// [NavigationRail] in landscape/wide mode (≥ 600 dp).
///
/// This gives the app proper landscape support without duplicating screen code.
class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _breakpoint = 600.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= _breakpoint;

    final destinations = _buildDestinations(l10n, tokens);

    if (isWide) {
      return Scaffold(
        backgroundColor: tokens.bg,
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onBranchSelected,
              labelType: NavigationRailLabelType.all,
              destinations: destinations
                  .map((d) => NavigationRailDestination(
                        icon: d.icon,
                        selectedIcon: d.selectedIcon ?? d.icon,
                        label: Text(d.label),
                      ))
                  .toList(),
            ),
            VerticalDivider(width: 1, color: tokens.sep),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: tokens.bg,
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onBranchSelected,
        destinations: destinations
            .map((d) => NavigationDestination(
                  icon: d.icon,
                  selectedIcon: d.selectedIcon ?? d.icon,
                  label: d.label,
                ))
            .toList(),
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  void _onBranchSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _NavDestination {
  const _NavDestination({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });
  final Widget icon;
  final Widget? selectedIcon;
  final String label;
}

List<_NavDestination> _buildDestinations(
    AppLocalizations l10n, AppTokens tokens) {
  return [
    _NavDestination(
      icon: const Icon(Icons.construction_outlined),
      selectedIcon: const Icon(Icons.construction),
      label: l10n.navBuild,
    ),
    _NavDestination(
      icon: const Icon(Icons.shield_outlined),
      selectedIcon: const Icon(Icons.shield),
      label: l10n.navEquipment,
    ),
    _NavDestination(
      icon: const Icon(Icons.bar_chart_outlined),
      selectedIcon: const Icon(Icons.bar_chart),
      label: l10n.navStats,
    ),
    _NavDestination(
      icon: const Icon(Icons.bookmark_outline),
      selectedIcon: const Icon(Icons.bookmark),
      label: l10n.navLoadouts,
    ),
  ];
}
