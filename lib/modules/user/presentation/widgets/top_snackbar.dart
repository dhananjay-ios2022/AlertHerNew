import 'package:flutter/material.dart';

import '../../../../core/constants/app_config.dart';

class TopSnackbar extends OverlayEntry {
  TopSnackbar({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
    IconData icon = Icons.error,
    Duration duration = const Duration(seconds: 3),
  }) : super(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 10,
      right: 10,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppDimensions.fixedScreenWidth,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: textColor),
                  const SizedBox(width: 10), // You can replace SB.h(10) with this
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  ) {
    _show(context, duration);
  }

  void _show(BuildContext context, Duration duration) {
    final overlay = Overlay.of(context);
    overlay.insert(this);
    Future.delayed(duration, remove);
  }
}
