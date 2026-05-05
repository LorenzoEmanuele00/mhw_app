import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/seed_service.dart';
import 'database_provider.dart';

final seedServiceProvider = Provider<SeedService>((ref) {
  return SeedService(ref.watch(databaseProvider));
});

/// FutureProvider che esegue il seeding al primo avvio.
/// Viene watched in main() prima di avviare l'app.
final seedInitProvider = FutureProvider<void>((ref) async {
  await ref.watch(seedServiceProvider).seedIfEmpty();
});
