import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/seed_provider.dart';
import 'core/router/router.dart';
import 'l10n/app_localizations.dart';
import 'shared/theme/app_theme.dart';

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
      // i18n — picks EN or IT automatically from system locale
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // Adaptive dark/light mode
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
