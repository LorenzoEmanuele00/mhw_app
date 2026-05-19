import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/database_provider.dart';
import 'sync_service.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(ref.watch(databaseProvider));
});

class SyncNotifier extends AsyncNotifier<SyncResult?> {
  bool _running = false;

  @override
  Future<SyncResult?> build() async => null;

  Future<void> run() async {
    if (_running) return;
    _running = true;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(syncServiceProvider).checkAndSync(),
    );
    _running = false;
  }
}

final syncNotifierProvider =
    AsyncNotifierProvider<SyncNotifier, SyncResult?>(SyncNotifier.new);
