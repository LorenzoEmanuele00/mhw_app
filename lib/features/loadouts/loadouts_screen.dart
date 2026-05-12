import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/large_title.dart';

/// Loadouts tab — placeholder until Phase 3.
class LoadoutsScreen extends StatelessWidget {
  const LoadoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LargeTitleBar(title: l10n.navLoadouts),
          Expanded(
            child: Center(
              child: Text(
                l10n.comingSoon,
                style: TextStyle(fontSize: 16, color: tokens.label2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
