import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/normal_text_field.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/app_strings.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/services/snackbar_manager.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/auth_view_model.dart';
import 'package:alert_her/modules/user/presentation/widgets/country_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_spinner.dart';

class EnterYourDetailsScreen extends StatefulWidget {
  final String countryCode;
  final String mobile;
  final String verifyToken;

  const EnterYourDetailsScreen(
      {super.key,
      this.countryCode = "",
      this.mobile = "",
      this.verifyToken = ""});

  @override
  State<EnterYourDetailsScreen> createState() => _EnterYourDetailsScreenState();
}

class _EnterYourDetailsScreenState extends State<EnterYourDetailsScreen> {
  final usernameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // var selectedCode = "";
  late AuthViewModel authVM;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  var selectedCountryCode = AppStrings.defaultCountryCode;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        setInitials();
      });
    });
    super.initState();
  }

  void setInitials() async {
    authVM = Provider.of<AuthViewModel>(context, listen: false);
     authVM.resetValues();
    if (widget.countryCode.isNotEmpty) {
      selectedCountryCode = widget.countryCode;
    }
    if (widget.mobile.isNotEmpty) {
      mobileNumberController.text = widget.mobile;
    }
    // await authVM.getGenderNationalityInitialize(context);
    // await authVM.getNationality(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Consumer<AuthViewModel>(builder: (mContext, authVM, child) {
          return Stack(
            fit: StackFit.expand,
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
                        onTap: () {
                          Navigator.of(context).pop();

                        },
                        child: SvgPicture.asset(
                          ConstImages.backArrow,
                          height: 28,
                          width: 28,
                        ),
                      ),
                      SB.h(30),
                      TextHeading(
                        text: AppLocalizations.of(context)
                            .translate('enterYourDetails'),
                        fontWeight: FontWeight.w700,
                        fontSize: 27,
                        color: MyColors.black,
                        fontFamily: 'meno_banner',
                      ),
                      SB.h(8),
                      TextSubHeading(
                        text: AppLocalizations.of(context)
                            .translate('pleaseEnterYourDetails'),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: MyColors.blackLight,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: 160,
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
                        // SB.h(10),
                        // TextSubHeading(
                        //   text: AppLocalizations.of(context)
                        //       .translate('enterUsername'),
                        //   fontWeight: FontWeight.w400,
                        //   fontSize: 13,
                        //   color: MyColors.blackLight,
                        // ),
                        // SB.h(10),
                        // NormalTextField(
                        //   controller: usernameController,
                        //   hintText: AppLocalizations.of(context)
                        //       .translate('username'),
                        //   inputType: TextInputType.text,
                        //   fillColor: MyColors.white,
                        // ),
                        SB.h(10),
                        TextSubHeading(
                          text: AppLocalizations.of(context).translate('email'),
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: MyColors.blackLight,
                        ),
                        SB.h(10),
                        NormalTextField(
                          controller: emailController,
                          hintText: AppLocalizations.of(context)
                              .translate('enterRegisteredEmail'),
                          inputType: TextInputType.text,
                          fillColor: MyColors.white,
                        ),
                        SB.h(15),
                        TextSubHeading(
                          text:
                              AppLocalizations.of(context).translate('phoneNo'),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: MyColors.blackLight,
                        ),
                        SB.h(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CountryPickerWidget(
                              isEnable: false,
                              initialCode: selectedCountryCode,
                              onCountrySelected: (String code) {
                                setState(() {
                                  selectedCountryCode = "+$code";
                                });
                              },
                            ),
                            SB.w(12),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: NormalTextField(
                                    controller: mobileNumberController,
                                    hintText: AppLocalizations.of(context)
                                        .translate('enter10DigitPhoneNo'),
                                    inputType: TextInputType.phone,
                                    isEnabled: false,
                                    fillColor: MyColors.white,
                                    iconPath: ConstImages.greenCheck,
                                    disableColor: MyColors.primaryLight,
                                    disableTextColor: MyColors.black,
                                    iconSpaceFromTop: 13,
                                    iconSpaceFromBottom: 13),
                              ),
                            ),
                          ],
                        ),
                        SB.h(15),
                        TextSubHeading(
                          text: AppLocalizations.of(context)
                              .translate('password'),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: MyColors.blackLight,
                        ),
                        SB.h(10),
                        NormalTextField(
                          height: 50,
                          controller: passwordController,
                          hintText: AppLocalizations.of(context)
                              .translate('password'),
                          inputType: TextInputType.text,
                          obscureText: isPasswordVisible ? false : true,
                          iconPath: isPasswordVisible
                              ? ConstImages.eyeOpen
                              : ConstImages.eye,
                          onSuffixIconTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        SB.h(15),
                        TextSubHeading(
                          text: AppLocalizations.of(context)
                              .translate('confirmPassword'),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: MyColors.blackLight,
                        ),
                        SB.h(10),
                        NormalTextField(
                          height: 50,
                          controller: confirmPasswordController,
                          hintText: AppLocalizations.of(context)
                              .translate('confirmPassword'),
                          inputType: TextInputType.text,
                          obscureText: isConfirmPasswordVisible ? false : true,
                          iconPath: isConfirmPasswordVisible
                              ? ConstImages.eyeOpen
                              : ConstImages.eye,
                          onSuffixIconTap: () {
                            setState(() {
                              isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                            });
                          },
                        ),
                        SB.h(15),
                        // TextSubHeading(
                        //   text:
                        //       AppLocalizations.of(context).translate('gender'),
                        //   fontSize: 13,
                        //   fontWeight: FontWeight.w400,
                        //   color: MyColors.blackLight,
                        // ),
                        // SB.h(10),
                        // CustomSpinner(
                        //   items: authVM.gender,
                        //   selectedItem: authVM.selectedGender,
                        //   onChanged: (selectedValue) {
                        //     authVM.updateGender(
                        //         selectedValue!); // Use a method to update and notify listeners
                        //   },
                        // ),
                        // SB.h(15),
                        // TextSubHeading(
                        //   text: AppLocalizations.of(context)
                        //       .translate('nationality'),
                        //   fontSize: 13,
                        //   fontWeight: FontWeight.w400,
                        //   color: MyColors.blackLight,
                        // ),
                        // SB.h(10),
                        // CustomSpinner(
                        //   items: authVM.nationalities,
                        //   selectedItem: authVM.selectedNationality,
                        //   onChanged: (selectedValue) {
                        //     authVM.updateNationalities(selectedValue!);
                        //   },
                        //   // isEnabled: widget.timelinesViewModel.isChequeAndRemittanceEnable,
                        // ),
                        // SB.h(15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<AuthViewModel>(builder: (mContext, authVM, child) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: PrimaryButton(
                  isLoading: authVM.isLoading,
                  buttonText: AppLocalizations.of(context).translate('save'),
                  onPressed: () {
                    // print(
                    //     "authVM.selectedGender------ ${authVM.selectedGender}");
                    // print(
                    //     "authVM.selectedNtionality------${authVM.selectedNationality}");
                   // var username = usernameController.text.trim();
                    var email = emailController.text.trim();
                    var mobile = mobileNumberController.text.trim();
                    var password = passwordController.text.trim();
                    var confirmPassword = confirmPasswordController.text.trim();
                    // var gender = authVM.selectedGender;
                    // var nationality = authVM.selectedNationality;
                    // if (username.isEmpty) {
                    //   SnackbarManager().showBottomSnack(
                    //       context,
                    //       AppLocalizations.of(context)
                    //           .translate('usernameCannotBeEmpty'));
                    // } else if (username.length > 25) {
                    //   SnackbarManager().showTopSnack(
                    //       context,
                    //       AppLocalizations.of(context)
                    //           .translate('usernameCannotExceed25Characters'));
                    // } else
                      if (email.isEmpty) {
                      SnackbarManager().showBottomSnack(
                          context,
                          AppLocalizations.of(context)
                              .translate('emailCannotBeEmpty'));
                    } else if (!email.contains('@') || !email.contains('.')) {
                      SnackbarManager().showBottomSnack(
                          context,
                          AppLocalizations.of(context)
                              .translate('emailInvalidFormat'));
                    } else if (mobile.isEmpty) {
                      SnackbarManager().showBottomSnack(
                          context,
                          AppLocalizations.of(context)
                              .translate('phoneNumberCannotBeEmpty'));
                    } else if (password.isEmpty) {
                      SnackbarManager().showBottomSnack(
                          context,
                          AppLocalizations.of(context)
                              .translate('passwordCannotBeEmpty'));
                    }else if (password.length < 8) {
                      SnackbarManager().showBottomSnack(
                          context,
                          AppLocalizations.of(context).translate(
                              'passwordMustBeAtLeast8Digits'));
                    }
                    else if (confirmPassword.isEmpty) {
                      SnackbarManager().showBottomSnack(
                          context,
                          AppLocalizations.of(context)
                              .translate('confirmPasswordCannotBeEmpty'));
                    } else if (password != confirmPassword) {
                      SnackbarManager().showBottomSnack(
                          context,
                          AppLocalizations.of(context)
                              .translate('passwordsDoNotMatch'));
                    }
                    // else if ((gender == AppLocalizations.of(context).translate('selectGender') || gender == null)) {
                    //   SnackbarManager().showBottomSnack(
                    //       context,
                    //       AppLocalizations.of(context)
                    //           .translate('pleaseSelectGender'));
                    // } else if ((nationality == AppLocalizations.of(context).translate('selectNationality') || nationality == null)) {
                    //   SnackbarManager().showBottomSnack(
                    //       context,
                    //       AppLocalizations.of(context)
                    //           .translate('pleaseSelectNationality'));
                    // }
                    else {
                      authVM.handleRegistrationDetails(context,
                         // username: username,
                          email: email,
                          countryCode: selectedCountryCode,
                          mobile: mobile,
                          password: password,
                          // gender: gender ==
                          //         AppLocalizations.of(context)
                          //             .translate('selectGender')
                          //     ? null
                          //     : gender,
                          // nationality: nationality ==
                          //         AppLocalizations.of(context)
                          //             .translate('selectNationality')
                          //     ? null
                          //     : nationality,
                          verifyToken: widget.verifyToken);
                    }
                  },
                ),
              );
            }),
            const NetworkStatus(),
          ],
        ),
      ),
    );
  }
}
