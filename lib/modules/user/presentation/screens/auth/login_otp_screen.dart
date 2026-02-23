import 'dart:async';

import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/services/snackbar_manager.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/core/utils/string_extension.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class LoginOtpScreen extends StatefulWidget {
  final String countryCode;
  final String mobile;
  final bool isShowComplete;

  const LoginOtpScreen({
    super.key,
    this.countryCode = "",
    this.mobile = "",
    this.isShowComplete = false,
  });

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  static const int initialCountdown = 30;
  late int _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    authVM.otpController.text = "";
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
    authVM.handleResendOTP(context, countryCode: widget.countryCode, mobile: widget.mobile,isResend: true);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<AuthViewModel>(builder: (mContext, authVM, child) {
          return Stack(
            children: [
              Positioned.fill(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: MyColors.primaryLight,
                  padding: const EdgeInsets.only(top: 25, left: 17, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: SvgPicture.asset(
                          ConstImages.backArrow,
                          height: 28,
                          width: 28,
                        ),
                      ),
                      SB.h(30),
                      TextHeading(
                        text: AppLocalizations.of(context)
                            .translate('verificationCode'),
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: MyColors.black,
                        fontFamily: 'meno_banner',
                      ),
                      SB.h(8),
                      TextSubHeading(
                        text:
                            "${AppLocalizations.of(context).translate('pleaseEnterYour6DigitCode')}${maskMobileFromEnd(widget.mobile)}",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: MyColors.blackLight,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: 180,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextSubHeading(
                          text: AppLocalizations.of(context)
                              .translate('enterOTP'),
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: MyColors.black,
                        ),
                        SB.h(10),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          child: Pinput(
                            closeKeyboardWhenCompleted: false,
                            autofocus: true,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            validator: (value) {
                              if (value!.isEmpty || value == "") {
                                return AppLocalizations.of(context)
                                    .translate('pleaseEnterOtp');
                              } else if (value.contains(" ")) {
                                return AppLocalizations.of(context)
                                    .translate('OTPNotAllowedSpace');
                              }
                              return null;
                            },
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            controller: authVM.otpController,
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
                                        width: .8, color: MyColors.gray))),
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
                                        width: .8, color: MyColors.primary))),
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
                        SB.h(30),
                        PrimaryButton(
                          buttonText:
                              AppLocalizations.of(context).translate('verify'),
                          isLoading: authVM.isLoading,
                          onPressed: () {
                            var phoneNumber = widget.mobile;
                            var countryCode = widget.countryCode.isNotEmpty ?  widget.countryCode : authVM.selectedCountryCode;
                            var otp = authVM.otpController.text;
                            if (otp.isEmpty) {
                              SnackbarManager().showBottomSnack(
                                  context,
                                  AppLocalizations.of(context)
                                      .translate('otpCannotBeEmpty'));
                            } else if (otp.contains(" ")) {
                              SnackbarManager().showBottomSnack(
                                  context,
                                  AppLocalizations.of(context)
                                      .translate('OTPNotAllowedSpace'));
                            } else if (otp.length != 6) {
                              SnackbarManager().showBottomSnack(
                                  context,
                                  AppLocalizations.of(context)
                                      .translate('otpInvalidFormat'));
                            }  else {
                              authVM.handleVerifyOTP(context,
                                  countryCode: countryCode,
                                  mobile: phoneNumber,
                                  otp: int.parse(otp),
                                  isShowComplete: widget.isShowComplete);
                            }
                          },
                        ),
                        SB.h(36),
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
                  ),
                ),
              ),
            ],
          );
        }),
        bottomNavigationBar: const NetworkStatus(),
      ),
    );
  }
  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}
