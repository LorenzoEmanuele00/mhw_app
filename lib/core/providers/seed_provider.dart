import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/seed_service.dart';
import '../sync/sync_notifier.dart';
import 'database_provider.dart';

final seedServiceProvider = Provider<SeedService>((ref) {
  return SeedService(ref.watch(databaseProvider));
});

/// Initializes game data on startup:
/// - Online → sync directly from Supabase (splash stays up until done).
/// - Offline → fall back to bundled SQL seed files.
///
/// After this resolves, the app is always in a usable state regardless
/// of connectivity. Subsequent online transitions are handled by the
/// connectivity listener in MhwApp.
final seedInitProvider = FutureProvider<void>((ref) async {
  final results = await Connectivity().checkConnectivity();
  final isOnline = results.any((r) => r != ConnectivityResult.none);

  if (isOnline) {
    await ref.watch(syncServiceProvider).checkAndSync();
  } else {
    await ref.watch(seedServiceProvider).seedIfEmpty();
  }
});
