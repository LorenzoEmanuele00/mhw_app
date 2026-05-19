import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/build/build_state.dart';
import '../../features/build/repository/builds_repository.dart';
import '../../shared/calc/build_resolver.dart';

class CompareNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void select(int id) => state = id;
  void stop() => state = null;
}

final compareNotifierProvider =
    NotifierProvider<CompareNotifier, int?>(CompareNotifier.new);

final compareBuildStateProvider =
    FutureProvider.family<BuildState?, int>((ref, buildId) async {
  final repo = ref.read(buildsRepositoryProvider);
  final build = await repo.getById(buildId);
  if (build == null) return null;
  return resolveBuild(build, ref);
});
