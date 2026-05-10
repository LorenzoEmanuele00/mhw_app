import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/large_title.dart';

/// Stats tab — placeholder until Phase 4.
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LargeTitleBar(title: l10n.navStats),
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
