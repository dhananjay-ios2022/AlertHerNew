import 'package:flutter/material.dart';


class BottomSnackbar extends OverlayEntry {
  BottomSnackbar({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
    IconData icon = Icons.error,
    Duration duration = const Duration(seconds: 3),
  }) : super(
    builder: (context) => Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom > 0
          ? MediaQuery.of(context).viewInsets.bottom + 10
          : MediaQuery.of(context).padding.bottom + 10,
      left: 10,
      right: 10,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400, // Update this according to your needs
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
                  const SizedBox(width: 10),
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

