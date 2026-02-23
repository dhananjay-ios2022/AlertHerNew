import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/normal_text_field.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/routes/routes.dart';
import 'package:alert_her/core/services/snackbar_manager.dart';
import 'package:alert_her/core/utils/app_utils.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/auth_view_model.dart';
import 'package:alert_her/modules/user/presentation/widgets/auth_footer.dart';
import 'package:alert_her/modules/user/presentation/widgets/country_picker_widget.dart';
import 'package:country_phone_validator/country_phone_validator.dart' as c;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../localizations/app_localizations.dart';

class LoginMobileScreen extends StatefulWidget {
  const LoginMobileScreen({super.key});

  @override
  State<LoginMobileScreen> createState() => _LoginMobileScreenState();
}

class _LoginMobileScreenState extends State<LoginMobileScreen> {
  late AuthViewModel authVM;
  bool isSelectedCheckbox1 = false;
  bool isSelectedCheckbox2 = false;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setup();
    });
    super.initState();
  }

  void setup() async {
    authVM = Provider.of<AuthViewModel>(context, listen: false);
    authVM.mobileNumberController.addListener(_detectCountryCodeFromInput);
  }

  void _detectCountryCodeFromInput() {
    final text = authVM.mobileNumberController.text;

    final cleanedText = AppUtils.detectAndCleanCountryCode(
      text: text,
      validCountryCodes: AppUtils.validCountryCodes,
      onCountryCodeDetected: (code) {
        setState(() {
          authVM.selectedCountryCode = code;
        });
      },
    );

    if (cleanedText != null) {
      setState(() {
        authVM.mobileNumberController.text = cleanedText;
        authVM.mobileNumberController.selection = TextSelection.fromPosition(
          TextPosition(offset: cleanedText.length),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<AuthViewModel>(builder: (mContext, authVM, child) {
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 300,
                      color: MyColors.primaryLight,
                      padding:
                          const EdgeInsets.only(top: 25, left: 25, right: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHeading(
                            text:
                                "👋 ${AppLocalizations.of(context).translate('hello')}",
                            fontWeight: FontWeight.w400,
                            fontSize: 27,
                            color: MyColors.black,
                            fontFamily: 'meno_banner',
                          ),
                          SB.h(8),
                          Row(
                            children: [
                              TextHeading(
                                text: AppLocalizations.of(context)
                                    .translate('welcomeTo'),
                                fontSize: 27,
                                color: MyColors.black,
                                fontFamily: 'meno_banner',
                              ),
                              SizedBox(
                                height: 29,
                                width: 127,
                                child: Image.asset(ConstImages.logo),
                              ),
                            ],
                          ),
                          SB.h(8),
                          TextSubHeading(
                            text: AppLocalizations.of(context)
                                .translate('letsLoginWithYourPhoneNo'),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: MyColors.blackLight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 230,
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
                            text:
                                AppLocalizations.of(context).translate('phoneNo'),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: MyColors.black,
                          ),
                          SB.h(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CountryPickerWidget(
                                initialCode: authVM.selectedCountryCode,
                                onCountrySelected: (String code) {
                                  setState(() {
                                    authVM.selectedCountryCode = "+$code";
                                  });
                                },
                              ),
                              SB.w(12),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: NormalTextField(
                                    controller: authVM.mobileNumberController,
                                    hintText: AppLocalizations.of(context)
                                        .translate('enter10DigitPhoneNo'),
                                    inputType: TextInputType.phone,
                                    isEnabled: true,
                                    fillColor: MyColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SB.h(25),
                          AuthFooter(
                            isSelectedCheckBox1: isSelectedCheckbox1,
                            onChangedCheckBox1: (value) {
                              setState(() {
                                isSelectedCheckbox1 = value!;
                              });
                              print(isSelectedCheckbox1);
                            } ,
                            isSelectedCheckBox2: isSelectedCheckbox2,
                            onChangedCheckBox2: (value) {
                              setState(() {
                                isSelectedCheckbox2 = value!;
                              });
                              print(isSelectedCheckbox2);
                            } ,
                          ),
                          SB.h(25),
                          Consumer<AuthViewModel>(
                              builder: (mContext, authVM, child) {
                            return SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                buttonText: AppLocalizations.of(context)
                                    .translate('sendOTP'),
                                isLoading: authVM.isLoading,
                                onPressed: () {
                                  var phoneNumber =
                                      authVM.mobileNumberController.text;
                                  bool isMobileWithCountryCodeValid =
                                      c.CountryUtils.validatePhoneNumber(
                                          phoneNumber,
                                          authVM.selectedCountryCode);
                                  if (phoneNumber.isEmpty) {
                                    SnackbarManager().showBottomSnack(
                                        context,
                                        AppLocalizations.of(context).translate(
                                            'phoneNumberCannotBeEmpty'));
                                  } else if (phoneNumber.length < 6) {
                                    SnackbarManager().showBottomSnack(
                                        context,
                                        AppLocalizations.of(context).translate(
                                            'phoneNumberMustBeAtLeastMoreThen5Digits'));
                                  } else if (!isMobileWithCountryCodeValid) {
                                    SnackbarManager().showBottomSnack(
                                      context,
                                      AppLocalizations.of(context).translate(
                                          'phoneNumberInvalidForSelectedCountry'),
                                    );
                                  }else if (!isSelectedCheckbox1) {
                                    SnackbarManager().showBottomSnack(
                                        context,
                                        AppLocalizations.of(context)
                                            .translate('acceptT&C'));
                                  }else if (!isSelectedCheckbox2) {
                                    SnackbarManager().showBottomSnack(
                                        context,
                                        AppLocalizations.of(context)
                                            .translate('acceptT&C'));
                                  } else {
                                    authVM.handleLogin(context,
                                        countryCode: authVM.selectedCountryCode,
                                        mobile: phoneNumber,
                                        loginType: "mobile");
                                  }
                                },
                              ),
                            );
                          }),
                          SB.h(36),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextSubHeading(
                                text: AppLocalizations.of(context)
                                    .translate('loginWithEmailInstead'),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: MyColors.blackLight,
                              ),
                              SB.w(5),
                              TextSubHeading(
                                text: AppLocalizations.of(context)
                                    .translate('clickHere'),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: MyColors.primaryDark,
                                onTap: () => context.push(Routes.loginEmail),
                              ),
                            ],
                          ),
                          SB.h(25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextSubHeading(
                                text: AppLocalizations.of(context)
                                    .translate('notAUser'),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: MyColors.blackLight,
                              ),
                              SB.w(5),
                              TextSubHeading(
                                text: AppLocalizations.of(context)
                                    .translate('registerNow'),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: MyColors.primaryDark,
                                onTap: () => context.push(Routes.registration),
                              ),
                            ],
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
      ),
    );
  }
}
