import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Search input field styled to match the design system (iOS-style pill).
class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    required this.controller,
    this.placeholder = 'Search',
    this.onChanged,
  });

  final TextEditingController controller;
  final String placeholder;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);

    return Container(
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: tokens.fill,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        spacing: 6,
        children: [
          Icon(Icons.search, size: 16, color: tokens.label2),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 17,
                color: tokens.label,
                letterSpacing: -0.43,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(color: tokens.label2),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                controller.clear();
                onChanged?.call('');
              },
              child: Icon(Icons.cancel, size: 16, color: tokens.label2),
            ),
        ],
      ),
    );
  }
}
