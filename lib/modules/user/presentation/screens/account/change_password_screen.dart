import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/normal_text_field.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/services/snackbar_manager.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/auth_view_model.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isCurrentPasswordVisible = false;
  bool isNewPasswordVisible = false;
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
                            text: AppLocalizations.of(context).translate('changePassword'),
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
                            TextHeading(
                              text: AppLocalizations.of(context).translate('changeYourPassword'),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: MyColors.black,
                            ),
                            SB.h(30),
                            TextSubHeading(text: AppLocalizations.of(context).translate('currentPassword'),fontSize: 13,fontWeight: FontWeight.w400,color: MyColors.blackLight,),
                            SB.h(10),
                            NormalTextField(
                              height: 50,
                              controller: currentPasswordController,
                              hintText: AppLocalizations.of(context).translate('currentPassword'),
                              inputType: TextInputType.text,
                              obscureText: isCurrentPasswordVisible ? false : true,
                              iconPath: isCurrentPasswordVisible ? ConstImages.eyeOpen : ConstImages.eye,
                              onSuffixIconTap: () {
                                setState(() {
                                  isCurrentPasswordVisible = !isCurrentPasswordVisible;
                                });
                              },
                            ),
                            SB.h(15),
                            TextSubHeading(text: AppLocalizations.of(context).translate('newPassword'),fontSize: 13,fontWeight: FontWeight.w400,color: MyColors.blackLight,),
                            SB.h(10),
                            NormalTextField(
                              height: 50,
                              controller: newPasswordController,
                              hintText: AppLocalizations.of(context).translate('newPassword'),
                              inputType: TextInputType.text,
                              obscureText: isNewPasswordVisible ? false : true,
                              iconPath: isNewPasswordVisible ? ConstImages.eyeOpen : ConstImages.eye,
                              onSuffixIconTap: () {
                                setState(() {
                                  isNewPasswordVisible = !isNewPasswordVisible;
                                });
                              },
                            ),
                            SB.h(15),
                            TextSubHeading(text: AppLocalizations.of(context).translate('confirmPasswordN'),fontSize: 13,fontWeight: FontWeight.w400,color: MyColors.blackLight,),
                            SB.h(10),
                            NormalTextField(
                              height: 50,
                              controller: confirmPasswordController,
                              hintText: AppLocalizations.of(context).translate('confirmPasswordN'),
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
                              buttonText: AppLocalizations.of(context).translate('saveNewPassword'),
                              fontWeight: FontWeight.w700,
                              textSize: 14,
                              isLoading: authVM.isLoading,
                              onPressed: () {
                                var currentPassword = currentPasswordController.text.trim();
                                var newPassword = newPasswordController.text.trim();
                                var confirmPassword = confirmPasswordController.text.trim();

                                if (currentPassword.isEmpty) {
                                  SnackbarManager().showTopSnack(context, AppLocalizations.of(context).translate('currentPasswordCannotBeEmpty'));
                                } else if (newPassword.isEmpty) {
                                  SnackbarManager().showTopSnack(context, AppLocalizations.of(context).translate('newPasswordCannotBeEmpty'));
                                }else if (confirmPassword.isEmpty) {
                                  SnackbarManager().showTopSnack(context, AppLocalizations.of(context).translate('confirmPasswordCannotBeEmpty'));
                                } else if (newPassword != confirmPassword) {
                                  SnackbarManager().showTopSnack(context, AppLocalizations.of(context).translate('newPasswordsDoNotMatch'));
                                }
                                else {
                                  authVM.handleChangePassword(context,currentPassword,newPassword);
                                }
                              },
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
}
