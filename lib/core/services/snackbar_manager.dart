import 'package:alert_her/modules/user/presentation/widgets/bottom_snackbar.dart';
import 'package:alert_her/modules/user/presentation/widgets/top_snackbar.dart';
import 'package:flutter/material.dart';

class SnackbarManager {
  static final SnackbarManager _instance = SnackbarManager._internal();

  factory SnackbarManager() {
    return _instance;
  }

  SnackbarManager._internal();
  void showBottomSnack(BuildContext context, String message,
      {Color backgroundColor = Colors.red, Color textColor = Colors.white, IconData icon = Icons.error, Duration duration = const Duration(seconds: 3)}) {
    BottomSnackbar(
      context: context,
      message: message,
      backgroundColor: backgroundColor,
      textColor: textColor,
      icon: icon,
      duration: duration,
    );
  }

  void showTopSnack(BuildContext context, String message,
      {Color backgroundColor = Colors.red, Color textColor = Colors.white, IconData icon = Icons.error, Duration duration = const Duration(seconds: 3)}) {
    TopSnackbar(
      context: context,
      message: message,
      backgroundColor: backgroundColor,
      textColor: textColor,
      icon: icon,
      duration: duration,
    );
  }


// Add more snackbar types as needed
}

