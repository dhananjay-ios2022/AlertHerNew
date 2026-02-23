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

class VerifyOtpDialog extends StatelessWidget {
  final String mobile;
  final String countryCode;
  final String heading;
  final String subHeading;
  final VoidCallback onButtonPressed;

  const VerifyOtpDialog({
    Key? key,
    required this.mobile,
    required this.countryCode,
    required this.heading,
    required this.subHeading,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Consumer<AuthViewModel>(
        builder: (mContext, authVM, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextSubHeading(text: heading,fontSize: 18,fontWeight: FontWeight.w500,color: MyColors.black,),
                SB.h(20),
                TextSubHeading(text: "$subHeading ${mobile.isNotEmpty == true ? maskMobileFromEnd(mobile) : ''}",fontSize: 13,fontWeight: FontWeight.w400,color: MyColors.black,textAlign: TextAlign.center,),
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
                    controller: authVM.otpVerifyController,
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
                SB.h(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        bgColor: MyColors.gray,
                        buttonText: AppLocalizations.of(context).translate('No'),
                        fontWeight: FontWeight.w700,
                        textColor: MyColors.black,
                        textSize: 14,
                        isLoading: false,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    SB.w(10),
                    Expanded(
                      child: PrimaryButton(
                        buttonText: AppLocalizations.of(context).translate('verifyDelete'),
                        fontWeight: FontWeight.w700,
                        textSize: 12,
                        isLoading: authVM.isLoading,
                        onPressed: onButtonPressed,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
    );
  }
}
