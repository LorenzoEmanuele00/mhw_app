import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Shows a modal bottom sheet using the design-system style.
/// The sheet respects the device's safe area and adapts its width in
/// landscape (max 600 dp centred) so it doesn't stretch across the full
/// screen on wide devices.
Future<T?> showAppSheet<T>({
  required BuildContext context,
  required Widget child,
  double initialSize = 0.86,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _AppSheetWrapper(initialSize: initialSize, child: child),
  );
}

class _AppSheetWrapper extends StatelessWidget {
  const _AppSheetWrapper({required this.child, required this.initialSize});

  final Widget child;
  final double initialSize;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final sheetWidth = mediaWidth > 600 ? 540.0 : mediaWidth;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: sheetWidth,
        child: DraggableScrollableSheet(
          initialChildSize: initialSize,
          minChildSize: 0.8,
          maxChildSize: initialSize,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: tokens.card,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x2E000000),
                    blurRadius: 30,
                    offset: Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Drag handle
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: 36,
                    height: 5,
                    decoration: BoxDecoration(
                      color: tokens.label3,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: child,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
