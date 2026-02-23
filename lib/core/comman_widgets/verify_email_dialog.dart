import 'dart:async';

import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/utils/string_extension.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'text_sub_heading.dart';
import '../utils/sb.dart';

class VerifyEmailDialog extends StatefulWidget {
  final String heading;
  final String subHeading;
  final String email;
  final VoidCallback onButtonPressed;
  final TextEditingController emailOTP;

  const VerifyEmailDialog({
    Key? key,
    required this.heading,
    required this.subHeading,
    required this.email,
    required this.onButtonPressed,
    required this.emailOTP,
  }) : super(key: key);

  @override
  State<VerifyEmailDialog> createState() => _VerifyEmailDialogState();
}

class _VerifyEmailDialogState extends State<VerifyEmailDialog> {
  static const int initialCountdown = 30;
  late int _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _remainingTime = initialCountdown;
    });

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel(); // Cancel the timer if the widget is no longer mounted
        return;
      }

      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _resendOtp() {
    _startCountdown();
    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    authVM.handleResendOTPOnEmail(context, email: widget.email);
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Consumer<AuthViewModel>(
        builder: (mContext, authVM, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextSubHeading(text: widget.heading,fontSize: 18,fontWeight: FontWeight.w500,color: MyColors.black,),
                SB.h(20),
                TextSubHeading(text: widget.subHeading,fontSize: 13,fontWeight: FontWeight.w400,color: MyColors.black,textAlign: TextAlign.center,),
                SB.h(15),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  child: Pinput(
                    closeKeyboardWhenCompleted: false,
                    autofocus: true,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    validator: (value) {
                      if (value!.isEmpty || value == "") {
                        return AppLocalizations.of(context).translate('pleaseEnterOtp');
                      } else if (value.contains(" ")) {
                        return AppLocalizations.of(context).translate('OTPNotAllowedSpace');
                      }
                      return null;
                    },
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    controller: widget.emailOTP,
                    length: 6,
                    cursor: Container(
                      width: 1,
                      height: 20,
                      color: MyColors.primary,
                    ),
                    // onChanged: onChanged,
                    animationCurve: Curves.bounceInOut,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    errorPinTheme: PinTheme(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: MyColors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: .5, color: MyColors.red))),
                    defaultPinTheme: PinTheme(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: MyColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: .5, color: MyColors.gray))),
                    submittedPinTheme: PinTheme(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: MyColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: MyColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: .8,
                                color: MyColors.gray))),
                    focusedPinTheme: PinTheme(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: MyColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: MyColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: .8,
                                color: MyColors.primary))),
                    followingPinTheme: PinTheme(
                        height: 50,
                        width: 50,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: MyColors.greenLight100,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: .5, color: MyColors.gray))),
                    showCursor: true,
                    // onCompleted: onCompleted,

                  ),
                ),
                SB.h(15),
                PrimaryButton(
                  buttonText: AppLocalizations.of(context).translate('verify'),
                  fontWeight: FontWeight.w700,
                  textSize: 16,
                  isLoading: authVM.isLoading,
                  onPressed: widget.onButtonPressed,
                ),
                SB.h(25),
                _remainingTime > 0
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextSubHeading(
                      text: AppLocalizations.of(context)
                          .translate('resendOTPIn'),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: MyColors.blackLight,
                    ),
                    SB.w(5),
                    TextSubHeading(
                      text: _formatTime(_remainingTime),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: MyColors.orange,
                    ),
                  ],
                )
                    : Align(
                  alignment: Alignment.center,
                  child: TextSubHeading(
                    text: AppLocalizations.of(context).translate('resendOTP'),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: MyColors.primary,
                    onTap: (){
                      _resendOtp();
                    },
                  ),
                ),
              ],
            ),
          );
        }),
    );
  }
  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}
