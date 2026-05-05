import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/seed_provider.dart';
import 'core/router/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MhwApp()));
}

class MhwApp extends ConsumerWidget {
  const MhwApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seed = ref.watch(seedInitProvider);

    return MaterialApp.router(
      title: 'MHW Builder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B1A1A),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
      // Mostra splash finché il seed non è pronto
      builder: seed.when(
        data: (_) => null,
        loading: () => (context, child) => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
        error: (e, _) => (context, child) => Scaffold(
              body: Center(child: Text('Init error: $e')),
            ),
      ),
    );
  }
}
