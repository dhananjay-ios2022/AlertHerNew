import 'package:alert_her/core/comman_widgets/block_dialog.dart';
import 'package:alert_her/core/comman_widgets/free_trail_dialog.dart';
import 'package:alert_her/core/comman_widgets/logout_dialog.dart';
import 'package:alert_her/core/comman_widgets/report_dialog.dart';
import 'package:alert_her/core/comman_widgets/verify_email_dialog.dart';
import 'package:alert_her/core/comman_widgets/verify_otp_dialog.dart';
import 'package:alert_her/core/comman_widgets/verify_password_dialog.dart';
import 'package:flutter/material.dart';
import '../comman_widgets/back_confirmation_dialog.dart';

class DialogManager {
  static final DialogManager _instance = DialogManager._internal();

  factory DialogManager() {
    return _instance;
  }

  DialogManager._internal();

  Future<bool> showBackConfirmationDialog({
    required BuildContext context,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return const BackConfirmationDialog();
          },
        ) ??
        false;
  }

  void showLogoutDeleteAccountDialog({
    required BuildContext context,
    required String heading,
    required String subHeading,
    required VoidCallback onButtonPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutAndDeleteAccountDialog(
          heading: heading,
          subHeading: subHeading,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }

  void showDeleteReportDialog({
    required BuildContext context,
    required String heading,
    required String subHeading,
    required VoidCallback onButtonPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutAndDeleteAccountDialog(
          heading: heading,
          subHeading: subHeading,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }

  void showVerifyOTPDialog({
    required BuildContext context,
    required String mobile,
    required String countryCode,
    required String heading,
    required String subHeading,
    required VoidCallback onButtonPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return VerifyOtpDialog(
          mobile: mobile,
          countryCode: countryCode,
          heading: heading,
          subHeading: subHeading,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }

  void showVerifyPasswordDialog({
    required BuildContext context,
    required String heading,
    required String subHeading,
    required VoidCallback onButtonPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return VerifyPasswordDialog(
          heading: heading,
          subHeading: subHeading,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }

  void showReportDialog({
    required BuildContext context,
    required List<String> reportType,
    required String id,
    required String report,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportDialog(
          reportType: reportType,
          id: id,
          report: report,
        );
      },
    );
  }

  void showVerifyEmailDialog({
    required BuildContext context,
    required String heading,
    required String subHeading,
    required String email,
    required TextEditingController emailOTP,
    required VoidCallback onButtonPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return VerifyEmailDialog(
          heading: heading,
          subHeading: subHeading,
          email: email,
          emailOTP: emailOTP,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }

  void showBlockDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false, child: const BlockDialog(),
        );
      },
    );
  }


  void showFreeTrialDialog({
    required BuildContext context,
    required String heading,
    required String subHeading,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FreeTrialDialog(
          heading: heading,
          subHeading: subHeading,
        );
      },
    );
  }

// Add more dialog types as needed
}
