import 'package:go_router/go_router.dart';
import '../../features/build/build_screen.dart';
import '../../features/equipment/equipment_screen.dart';
import '../../features/loadouts/loadouts_screen.dart';
import '../../features/stats/stats_screen.dart';
import 'app_scaffold.dart';

final router = GoRouter(
  initialLocation: '/build',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/build',
            builder: (_, _) => const BuildScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/equipment',
            builder: (_, _) => const EquipmentScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/stats',
            builder: (_, _) => const StatsScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/loadouts',
            builder: (_, _) => const LoadoutsScreen(),
          ),
        ]),
      ],
    ),
  ],
);
