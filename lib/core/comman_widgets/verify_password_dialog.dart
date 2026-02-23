import 'package:alert_her/core/comman_widgets/normal_text_field.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'text_sub_heading.dart';
import '../utils/sb.dart';

class VerifyPasswordDialog extends StatefulWidget {
  final String heading;
  final String subHeading;
  final VoidCallback onButtonPressed;

  const VerifyPasswordDialog({
    Key? key,
    required this.heading,
    required this.subHeading,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  State<VerifyPasswordDialog> createState() => _VerifyPasswordDialogState();
}

class _VerifyPasswordDialogState extends State<VerifyPasswordDialog> {
  @override
  Widget build(BuildContext context) {



    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Consumer<AuthViewModel>(
        builder: (mContext, authVM, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextSubHeading(text: widget.heading,fontSize: 18,fontWeight: FontWeight.w500,color: MyColors.black,),
                SB.h(15),
                TextSubHeading(text: widget.subHeading,fontSize: 13,fontWeight: FontWeight.w400,color: MyColors.black,textAlign: TextAlign.center,),
                SB.h(15),
                Align(alignment:Alignment.topLeft,child: TextSubHeading(text: AppLocalizations.of(context).translate('password'),fontSize: 13,fontWeight: FontWeight.w400,color: MyColors.blackLight,)),
                SB.h(10),
                NormalTextField(
                  height: 50,
                  controller: authVM.passwordController,
                  hintText: AppLocalizations.of(context).translate('enterPassword'),
                  inputType: TextInputType.text,
                  obscureText: authVM.isPasswordVisible ? false : true,
                  iconPath: authVM.isPasswordVisible ? ConstImages.eyeOpen : ConstImages.eye,
                  onSuffixIconTap: () {
                    setState(() {
                      authVM.isPasswordVisible = !authVM.isPasswordVisible;
                    });
                  },
                ),
                SB.h(15),
                Align(alignment:Alignment.topLeft,child: TextSubHeading(text: AppLocalizations.of(context).translate('confirmPassword'),fontSize: 13,fontWeight: FontWeight.w400,color: MyColors.blackLight,)),
                SB.h(10),
                NormalTextField(
                  height: 50,
                  controller: authVM.confirmPasswordController,
                  hintText: AppLocalizations.of(context).translate('enterPassword'),
                  inputType: TextInputType.text,
                  obscureText: authVM.isConfirmPasswordVisible ? false : true,
                  iconPath: authVM.isConfirmPasswordVisible ? ConstImages.eyeOpen : ConstImages.eye,
                  onSuffixIconTap: () {
                    setState(() {
                      authVM.isConfirmPasswordVisible = !authVM.isConfirmPasswordVisible;
                    });
                  },
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
                        buttonText: AppLocalizations.of(context).translate('delete'),
                        fontWeight: FontWeight.w700,
                        textSize: 14,
                        isLoading: authVM.isLoading,
                        onPressed: widget.onButtonPressed,
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
