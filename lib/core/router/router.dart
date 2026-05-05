import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/equipment/weapons/weapons_screen.dart';
import '../../features/equipment/armor/armor_screen.dart';
import '../../features/equipment/jewels/jewels_screen.dart';
import '../../features/equipment/talismans/talismans_screen.dart';
import '../../features/builds/builds_screen.dart';
import '../../features/builder/builder_screen.dart';

final router = GoRouter(
  initialLocation: '/equipment/weapons',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ScaffoldWithNav(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/equipment',
            redirect: (_, _) => '/equipment/weapons',
          ),
          GoRoute(
            path: '/equipment/weapons',
            builder: (_, _) => const WeaponsScreen(),
          ),
          GoRoute(
            path: '/equipment/armor',
            builder: (_, _) => const ArmorScreen(),
          ),
          GoRoute(
            path: '/equipment/jewels',
            builder: (_, _) => const JewelsScreen(),
          ),
          GoRoute(
            path: '/equipment/talismans',
            builder: (_, _) => const TalismansScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/builds',
            builder: (_, _) => const BuildsScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/builder',
            builder: (_, _) => const BuilderScreen(),
          ),
          GoRoute(
            path: '/builder/:id',
            builder: (_, state) =>
                BuilderScreen(buildId: int.tryParse(state.pathParameters['id']!)),
          ),
        ]),
      ],
    ),
  ],
);

class ScaffoldWithNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithNav({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.shield), label: 'Equipment'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Builds'),
          NavigationDestination(icon: Icon(Icons.build), label: 'Builder'),
        ],
      ),
    );
  }
}
