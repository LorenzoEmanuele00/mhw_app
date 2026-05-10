import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Screen header with large title, optional subtitle, leading and trailing
/// widgets — matches the iOS LargeTitle navigation style.
class LargeTitleBar extends StatelessWidget {
  const LargeTitleBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leading != null || trailing != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  leading ?? const SizedBox.shrink(),
                  trailing ?? const SizedBox.shrink(),
                ],
              ),
            ),
          Text(
            title,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              color: tokens.label,
              height: 41 / 34,
            ),
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 15,
                  color: tokens.label2,
                  letterSpacing: -0.24,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A tappable text button styled as a header action (e.g. "Filter", "+ New").
class HeaderAction extends StatelessWidget {
  const HeaderAction({
    super.key,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 17,
          fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w400,
          color: tokens.accent,
          letterSpacing: -0.43,
        ),
      ),
    );
  }
}
