import 'dart:convert';

import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/normal_text_field.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/app_config.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/routes/routes.dart';
import 'package:alert_her/core/services/local_storage.dart';
import 'package:alert_her/core/services/snackbar_manager.dart';
import 'package:alert_her/core/utils/app_utils.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/core/utils/string_extension.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/home_view_model.dart';
import 'package:alert_her/modules/user/presentation/widgets/country_picker_widget.dart';
import 'package:country_phone_validator/country_phone_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/services/local_shared_prefs.dart';
import '../../../data/models/responses/local_subscription_response.dart';
import '../../../data/models/responses/registration_response.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late FocusNode _focusNode;
  final localStorage = LocalStorage();
  var subscriptionStatus = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Consumer<HomeViewModel>(
            builder: (mContext, homeVM, child) {
              
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
                      const EdgeInsets.only(top: 20, left: 18, right: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: ()=> context.pushReplacement(Routes.home),
                            child: Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: SvgPicture.asset(
                                ConstImages.backArrow,
                                height: 28,
                                width: 28,
                              ),
                            ),
                          ),
                          SB.w(15),
                          CountryPickerWidget(
                            initialCode: homeVM.selectedCountryCode,
                            bgColor: MyColors.white,
                            radius: 100,
                            onCountrySelected: (String code) {
                              setState(() {
                                homeVM.selectedCountryCode = "+$code";
                              });
                            },
                          ),

                          SB.w(8),
                          Expanded(
                            child: Stack(
                              children: [
                                NormalTextField(
                                  focusNode: _focusNode,
                                  height: 50,
                                  controller: homeVM.mobileNumberController,
                                  hintText: AppLocalizations.of(context).translate('searchMobileNumber'),
                                  inputType: TextInputType.phone,
                                  isEnabled: true,
                                  fillColor: MyColors.white,
                                  fillActiveColor: MyColors.white,
                                  iconPath: !homeVM.isLoading ? ConstImages.searchInCircle : null,
                                  borderRadius: 100,
                                  iconSpaceFromTop: 5,
                                  rightMargin: 8,
                                  onSuffixIconTap: !homeVM.isLoading ? () {
                                    var mobile = homeVM.mobileNumberController.text.trim();
                                    bool isMobileWithCountryCodeValid = CountryUtils.validatePhoneNumber(mobile, homeVM.selectedCountryCode);
                                    if (mobile.isEmpty) {
                                      SnackbarManager().showBottomSnack(context,AppLocalizations.of(context).translate('phoneNumberCannotBeEmpty'),);
                                    } else if (mobile.length < 6) {
                                      SnackbarManager().showBottomSnack(context, AppLocalizations.of(context).translate('phoneNumberMustBeAtLeastMoreThen5Digits'));
                                    }else if (!isMobileWithCountryCodeValid) {
                                      SnackbarManager().showBottomSnack(
                                        context,
                                        AppLocalizations.of(context)
                                            .translate('phoneNumberInvalidForSelectedCountry'),
                                      );
                                    }
                                    else {
                                      homeVM.searchMobileNumber(
                                        context,
                                        homeVM.selectedCountryCode,
                                        mobile,
                                      );
                                    }
                                  } : null,
                                ),
                                Visibility(
                                  visible: homeVM.isLoading,
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    padding: const EdgeInsets.all(12),
                                    child: const CupertinoActivityIndicator(
                                      radius: 12.0,
                                      color: MyColors.primary,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned.fill(
                    top: 90,
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
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          if(homeVM.showView == "search" && homeVM.searchResult.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child:  TextHeading(
                              text: (homeVM.searchResult.length > 1) ? "${homeVM.searchResult.length} ${AppLocalizations.of(context).translate('matchFound')}" : AppLocalizations.of(context).translate('oneMatchFound'),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: MyColors.black,
                            ),
                          ),
                          if(homeVM.showView == "search" && homeVM.searchResult.isNotEmpty)
                          Positioned.fill(
                            top: 35,
                            left: 0,
                            right: 0,
                            child: ListView.builder(
                              itemCount: homeVM.searchResult.length,
                              itemBuilder: (context, index) {
                                var item = homeVM.searchResult[index];
                                return GestureDetector(
                                  onTap: () async {
                                    final prefs = await SharedPreferences.getInstance();
                                    var status = prefs.getBool('review_intro') ?? true;
                                    if (status == true) {
                                      context.push(Routes.allReviewIntro,
                                          extra: {
                                            'countryCode': item.countryCode ?? "",
                                            'mobile': item .mobile ?? "",
                                            'name': item .lastReviewedName ?? ""
                                          });
                                    } else {
                                      if(subscriptionStatus) {
                                        var homeVM = Provider.of<HomeViewModel>(context,listen: false);
                                        homeVM.resetSearchValues();
                                        homeVM.resetReviewValues();
                                        context.push(
                                            Routes.allReview,
                                            extra: {
                                              'countryCode': item.countryCode ??
                                                  "",
                                              'mobile': item.mobile ?? "",
                                              'name': item.lastReviewedName ??
                                                  ""
                                            });
                                      }else{
                                        context.push(Routes.subscription);
                                      }
                                    }
                                  },
                                  child: Container(
                                    height:105,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                    decoration: BoxDecoration(
                                      color: MyColors.grayLight,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  TextSubHeading(text: "${item.countryCode ?? ""}- ${item.mobile ?? ""}",fontSize: 18),
                                                  //  TextSubHeading(text: "${item.countryCode ?? ""}- ${maskMobile(item.mobile ?? "")}",fontSize: 18),
                                                  SB.w(5),
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      color: MyColors.white,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: getColor(item.maxFlag!),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ClipOval(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(3.0),
                                                        child: SvgPicture.asset(
                                                          ConstImages.flag,
                                                          colorFilter: ColorFilter.mode(getColor(item.maxFlag!), BlendMode.srcIn),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SB.h(7),
                                              TextSubHeading(text: item.lastReviewedName !=null ? capitalizeEachWord(item.lastReviewedName!) : "",fontSize: 15,fontWeight: FontWeight.w600,color: MyColors.orange,),
                                              SB.h(16),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  TextSubHeading(text: "${AppLocalizations.of(context).translate('totalReviews')} : ${item.totalCount ?? ""}",color: MyColors.grayDark900,),
                                                  TextSubHeading(text: AppLocalizations.of(context).translate('viewAll'),color: MyColors.primaryDark,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if(homeVM.showView == "addReview")
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 40.0),
                                child: TextHeading(
                                  text: AppLocalizations.of(context).translate('thisNumberHasNotBeenReviewedYet'),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  maxLines: 2,
                                  color: MyColors.orange,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              PrimaryButton(
                                buttonText: AppLocalizations.of(context)
                                    .translate('addReview'),
                                fontWeight: FontWeight.w700,
                                isLoading: false,
                                onPressed: () {
                                  if(loggedInMobileNumber == homeVM.mobileNumberController && loggedInMobileNumberCountryCode == homeVM.selectedCountryCode){
                                    context.push(Routes.addReview, extra: {
                                      'callFrom': "home",
                                    });
                                  }else {
                                    context.push(Routes.addReview, extra: {
                                      'countryCode': homeVM.selectedCountryCode,
                                      'mobile': homeVM.mobileNumberController.text,
                                      'callFrom': "home",
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          Center(
                            child: Opacity(
                              opacity: 0.3,
                              child: Image.asset(ConstImages.logo),
                            ),
                          ),
                        ],
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

  @override
  void initState() {
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      getSubscriptionData();
      reset();

    });
    super.initState();
  }
  var loggedInMobileNumber="";
  var loggedInMobileNumberCountryCode="";
  late HomeViewModel homeVM;
  SharedPref sharedPref = SharedPref();


  void reset() async {
     homeVM = Provider.of<HomeViewModel>(context, listen: false);
    await homeVM.resetSearchValues();
    final localStorage = LocalStorage();
    final userInfo = await localStorage.getAdditionalUserInfo();
    loggedInMobileNumber = userInfo["phoneNo"] ?? "";
    loggedInMobileNumberCountryCode = userInfo["countryCode"] ?? "";

    homeVM.mobileNumberController.addListener(_detectCountryCodeFromInput);

  }


  getSubscriptionData() async {
    String? jsonString = await sharedPref.read(
        "user"); // Get the stored JSON String
    if (jsonString != null) {
      Map<String, dynamic> jsonData = json.decode(
          jsonString); //  Convert String to Map
      LocalSubscriptionResponse loginData = LocalSubscriptionResponse.fromJson(
          jsonData); // Now pass the Map
      print(loginData.toJson());
      subscriptionStatus = loginData.subscriptionStatus!;
    }
  }


  void _detectCountryCodeFromInput() {
    final text = homeVM.mobileNumberController.text;

    final cleanedText = AppUtils.detectAndCleanCountryCode(
      text: text,
      validCountryCodes: AppUtils.validCountryCodes,
      onCountryCodeDetected: (code) {
        setState(() {
          homeVM.selectedCountryCode = code;
        });
      },
    );

    if (cleanedText != null) {
      setState(() {
        homeVM.mobileNumberController.text = cleanedText;
        homeVM.mobileNumberController.selection = TextSelection.fromPosition(
          TextPosition(offset: cleanedText.length),
        );
      });
    }
  }







}


