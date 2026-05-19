import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/providers/seed_provider.dart';
import 'core/router/router.dart';
import 'core/sync/sync_notifier.dart'; // needed for connectivity re-trigger
import 'l10n/app_localizations.dart';
import 'shared/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://annwuzuszqdqmkstdags.supabase.co',
    anonKey: 'sb_publishable_aU94BwCGmHy9Dk_RQST2Iw_k4oJDtsx',
  );
  runApp(const ProviderScope(child: MhwApp()));
}

class MhwApp extends ConsumerStatefulWidget {
  const MhwApp({super.key});

  @override
  ConsumerState<MhwApp> createState() => _MhwAppState();
}

class _MhwAppState extends ConsumerState<MhwApp> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  // Track last result to detect offline→online transitions.
  bool _wasOffline = true;

  @override
  void initState() {
    super.initState();
    _connectivitySub = Connectivity().onConnectivityChanged.listen((results) {
      final isOnline = results.any((r) => r != ConnectivityResult.none);
      if (isOnline && _wasOffline) {
        ref.read(syncNotifierProvider.notifier).run();
      }
      _wasOffline = !isOnline;
    });
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seed = ref.watch(seedInitProvider);

    return MaterialApp.router(
      title: 'MHW Builder',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
      builder: seed.when(
        data: (_) => null,
        loading: () => (context, child) => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
        error: (e, _) => (context, child) => Scaffold(
              body: Center(
                child: Builder(
                  builder: (ctx) {
                    final l10n = Localizations.of<AppLocalizations>(
                      ctx,
                      AppLocalizations,
                    );
                    return Text(l10n?.initError(e) ?? 'Init error: $e');
                  },
                ),
              ),
            ),
      ),
    );
  }
}
