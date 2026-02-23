import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/normal_text_field.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/services/snackbar_manager.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../localizations/app_localizations.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String resetOTP;
  final String email;
  final String token;
  const ResetPasswordScreen({super.key,required this.resetOTP, required this.email,required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Consumer<AuthViewModel>(
            builder: (mContext, authVM, child) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: MyColors.primaryLight,
                      padding:
                      const EdgeInsets.only(top: 25, left: 17, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: ()=> Navigator.of(context).pop(),
                            child: SvgPicture.asset(
                              ConstImages.backArrow,
                              height: 28,
                              width: 28,
                            ),
                          ),
                          SB.w(20),
                          TextHeading(
                            text: AppLocalizations.of(context).translate('resetPasswordTitle'),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: MyColors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: 70,
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
                      padding:
                      const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SB.h(5),
                            TextHeading(
                              text: AppLocalizations.of(context).translate('pleaseEnterYourNewPassword'),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: MyColors.black,
                            ),
                            SB.h(25),
                            TextSubHeading(text: AppLocalizations.of(context).translate('newPassword'),fontSize: 13,fontWeight: FontWeight.w400,color: MyColors.blackLight,),
                            SB.h(10),
                            NormalTextField(
                              height: 50,
                              controller: passwordController,
                              hintText: AppLocalizations.of(context).translate('newPassword'),
                              inputType: TextInputType.text,
                              obscureText: isPasswordVisible ? false : true,
                              iconPath: isPasswordVisible ? ConstImages.eyeOpen : ConstImages.eye,
                              onSuffixIconTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            SB.h(15),
                            TextSubHeading(text: AppLocalizations.of(context).translate('confirmPassword'),fontSize: 13,fontWeight: FontWeight.w400,color: MyColors.blackLight,),
                            SB.h(10),
                            NormalTextField(
                              height: 50,
                              controller: confirmPasswordController,
                              hintText: AppLocalizations.of(context).translate('confirmPassword'),
                              inputType: TextInputType.text,
                              obscureText: isConfirmPasswordVisible ? false : true,
                              iconPath: isConfirmPasswordVisible ? ConstImages.eyeOpen : ConstImages.eye,
                              onSuffixIconTap: () {
                                setState(() {
                                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                });
                              },
                            ),
                            SB.h(50),
                            PrimaryButton(
                              isLoading: authVM.isLoading,
                              buttonText: AppLocalizations.of(context).translate('savePassword'),
                              onPressed: () {
                                var password = passwordController.text.trim();
                                var confirmPassword = confirmPasswordController.text.trim();

                                // Validation logic
                                if (password.isEmpty) {
                                  SnackbarManager().showBottomSnack(
                                    context,
                                    AppLocalizations.of(context).translate('passwordCannotBeEmpty'),
                                  );
                                } else if (confirmPassword.isEmpty) {
                                  SnackbarManager().showBottomSnack(
                                    context,
                                    AppLocalizations.of(context).translate('confirmPasswordCannotBeEmpty'),
                                  );
                                }
                                // else if (password.length < 8) {
                                //   SnackbarManager().showBottomSnack(
                                //     context,
                                //     AppLocalizations.of(context).translate('passwordMustBeAtLeast8Chars'),
                                //   );
                                // }
                                // else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$').hasMatch(password)) {
                                //   SnackbarManager().showBottomSnack(
                                //     context,
                                //     AppLocalizations.of(context).translate('passwordRequirements'),
                                //   );
                                // }
                                else if (password != confirmPassword) {
                                  SnackbarManager().showBottomSnack(
                                    context,
                                    AppLocalizations.of(context).translate('passwordsDoNotMatch'),
                                  );
                                } else {
                                  authVM.handleResetPassword(context,password,int.parse(widget.resetOTP),widget.email,widget.token);
                                }
                              },
                            )
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
}
