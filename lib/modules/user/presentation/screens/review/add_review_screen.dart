import 'package:alert_her/core/comman_widgets/large_text_field.dart';
import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/normal_text_field.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/services/local_storage.dart';
import 'package:alert_her/core/services/snackbar_manager.dart';
import 'package:alert_her/core/utils/app_utils.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/home_view_model.dart';
import 'package:alert_her/modules/user/presentation/widgets/country_picker_widget.dart';
import 'package:alert_her/modules/user/presentation/widgets/flag_with_text.dart';
import 'package:country_phone_validator/country_phone_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class AddReviewScreen extends StatefulWidget {
  final String countryCode;
  final String mobile;
  final String name;
  final String callFrom;

  const AddReviewScreen({
    super.key,
    this.countryCode = "",
    this.mobile = "",
    this.name = "",
    this.callFrom = "",
  });

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {

  List<Map<String, dynamic>> _getFlagItems(BuildContext context) {
    return [
      {
        'borderColor': MyColors.green,
        'bgColor': MyColors.greenLight,
        'text': AppLocalizations.of(context).translate('positiveExperience'),
        'id': 1,
      },
      {
        'borderColor': MyColors.green500,
        'bgColor': MyColors.greenLight100,
        'text': AppLocalizations.of(context).translate('neutralExperience'),
        'id': 2,
      },
      {
        'borderColor': MyColors.yellow,
        'bgColor': MyColors.yellowLight,
        'text': AppLocalizations.of(context).translate('missedAppointment'),
        'id': 3,
      },
      {
        'borderColor': MyColors.orange500,
        'bgColor': MyColors.orangeLight100,
        'text': AppLocalizations.of(context)
            .translate('reportedSafetyConcern'),
        'id': 4,
      },
      {
        'borderColor': MyColors.red,
        'bgColor': MyColors.redLight,
        'text': AppLocalizations.of(context)
            .translate('unverifiedLandlordAgencyOrOthers'),
        'id': 5,
      },
    ];
  }

  final GlobalKey _rone = GlobalKey();
  //final GlobalKey _rtwo = GlobalKey();
  final GlobalKey _rthree = GlobalKey();
  bool isSelectedCheckbox = false;

  @override
  Widget build(BuildContext context) {
    final _flagItems = _getFlagItems(context);
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Consumer<HomeViewModel>(
          builder: (mContext, homeVM, child) {
            return Stack(
              fit: StackFit.expand,
              children: [
                // Top Header
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
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(
                            ConstImages.backArrow,
                            height: 28,
                            width: 28,
                          ),
                        ),
                        SB.w(20),
                        TextHeading(
                          text: AppLocalizations.of(context)
                              .translate('addNewReview'),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: MyColors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                // Main Content
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
                      physics: _isFieldEnabled
                          ? const BouncingScrollPhysics() // Enable scrolling
                          : const NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SB.h(5),
                          TextHeading(
                            text: AppLocalizations.of(context)
                                .translate('chooseFlagColor'),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: MyColors.black,
                          ),
                          SB.h(15),
                          Column(
                            children: List.generate(
                              _flagItems.length,
                              (index) {
                                final item = _flagItems[index];
                                final isSelected =
                                    homeVM.selectedIndex == index;
                                return GestureDetector(
                                  onTap: _isFieldEnabled ? () {
                                    setState(() {
                                      homeVM.selectedIndex = index;
                                      homeVM.selectedId = item['id'];
                                    });
                                  } : null,
                                  child: index == 2 ? Showcase.withWidget(
                                    key: _rone,
                                    height: 80,
                                    width: 180,
                                    disableDefaultTargetGestures:true,
                                    targetPadding:const EdgeInsets.symmetric(horizontal: 6),
                                    targetBorderRadius : const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    container: Stack(
                                      children: [
                                        const Positioned(
                                          top:-20,
                                          child: Icon(
                                            Icons.arrow_drop_up,
                                            color: MyColors.primary,
                                            size: 50,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          margin: const EdgeInsets.only(top: 8),
                                          decoration: BoxDecoration(
                                            color: MyColors.primary,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextSubHeading(
                                                text: AppLocalizations.of(context).translate('chooseFlag'),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: MyColors.white,
                                              ),
                                              SB.h(8),
                                              TextSubHeading(
                                                text: AppLocalizations.of(context).translate('chooseTheFlagCategoryThatBestDescribesYourExperience'),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: MyColors.white,
                                              ),
                                              SB.h(30),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  TextSubHeading(
                                                    text: AppLocalizations.of(context).translate('skip'),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: MyColors.white,
                                                    onTap: (){
                                                      ShowCaseWidget.of(mContext).completed(_rone);
                                                      addReviewIntroductionStatus(false);
                                                    },
                                                  ),
                                                  SB.w(90),
                                                  TextSubHeading(
                                                    text: AppLocalizations.of(context).translate('next'),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12,
                                                    color: MyColors.white,
                                                    onTap: (){
                                                      ShowCaseWidget.of(mContext).startShowCase([_rthree]);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                      child: FlagWithText(
                                        borderColor: item['borderColor'],
                                        isSelectedColor: isSelected
                                            ? MyColors.primary
                                            : item['borderColor'],
                                        strockWidth: isSelected ? 2 : 1,
                                        bgColor: item['bgColor'],
                                        text: item['text'],
                                      ),
                                    ),
                                  ) : Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                    child: FlagWithText(
                                      borderColor: item['borderColor'],
                                      isSelectedColor: isSelected
                                          ? MyColors.primary
                                          : item['borderColor'],
                                      strockWidth: isSelected ? 2 : 1,
                                      bgColor: item['bgColor'],
                                      text: item['text'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SB.h(10),
                          TextSubHeading(
                            text: AppLocalizations.of(context)
                                .translate('enterMobileNumber'),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: MyColors.blackLight,
                          ),
                          SB.h(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CountryPickerWidget(
                                initialCode: homeVM.selectedCountryCode,
                                onCountrySelected: (String code) {
                                  setState(() {
                                    homeVM.selectedCountryCode = "+$code";
                                  });
                                },
                              ),
                              SB.w(12),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: NormalTextField(
                                    controller: homeVM.mobileNumberController,
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
                          SB.h(15),
                          // TextSubHeading(
                          //   text: AppLocalizations.of(context)
                          //       .translate('enterClientsName'),
                          //   fontSize: 13,
                          //   fontWeight: FontWeight.w400,
                          //   color: MyColors.blackLight,
                          // ),
                          // SB.h(10),
                          // Showcase.withWidget(
                          //   key: _rtwo,
                          //   height: 80,
                          //   width: 180,
                          //   disableDefaultTargetGestures:true,
                          //   targetPadding:const EdgeInsets.all(5),
                          //   targetBorderRadius : const BorderRadius.all(
                          //     Radius.circular(10),
                          //   ),
                          //   container: Stack(
                          //     children: [
                          //       const Positioned(
                          //         top:-20,
                          //         child: Icon(
                          //           Icons.arrow_drop_up,
                          //           color: MyColors.primary,
                          //           size: 50,
                          //         ),
                          //       ),
                          //       Container(
                          //         padding: const EdgeInsets.all(12),
                          //         margin: const EdgeInsets.only(top: 8),
                          //         decoration: BoxDecoration(
                          //           color: MyColors.primary,
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //         child: Column(
                          //           mainAxisSize: MainAxisSize.max,
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             TextSubHeading(
                          //               text: AppLocalizations.of(context).translate('addYourClientName'),
                          //               fontWeight: FontWeight.w700,
                          //               fontSize: 14,
                          //               color: MyColors.white,
                          //             ),
                          //             SB.h(8),
                          //             TextSubHeading(
                          //               text: AppLocalizations.of(context).translate('clientNameIfKnow'),
                          //               fontWeight: FontWeight.w400,
                          //               fontSize: 12,
                          //               color: MyColors.white,
                          //             ),
                          //             SB.h(30),
                          //             Row(
                          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 TextSubHeading(
                          //                   text: AppLocalizations.of(context).translate('skip'),
                          //                   fontWeight: FontWeight.w400,
                          //                   fontSize: 12,
                          //                   color: MyColors.white,
                          //                   onTap: (){
                          //                     ShowCaseWidget.of(context).completed(_rtwo);
                          //                     addReviewIntroductionStatus(false);
                          //                   },
                          //                 ),
                          //                 SB.w(110),
                          //                 TextSubHeading(
                          //                   text: AppLocalizations.of(context).translate('next'),
                          //                   fontWeight: FontWeight.w700,
                          //                   fontSize: 12,
                          //                   color: MyColors.white,
                          //                   onTap: (){
                          //                     ShowCaseWidget.of(context).startShowCase([_rthree]);
                          //                   },
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          //   child: NormalTextField(
                          //     height: 50,
                          //     controller: homeVM.nameController,
                          //     hintText: AppLocalizations.of(context)
                          //         .translate('enterName'),
                          //     inputType: TextInputType.text,
                          //     isEnabled: _isFieldEnabled,
                          //     disableColor: Colors.white,
                          //   ),
                          // ),
                          SB.h(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextSubHeading(
                                text: AppLocalizations.of(context)
                                    .translate('enterDescription'),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: MyColors.blackLight,
                              ),
                              TextSubHeading(
                                text: '${_remainingWords.clamp(0, maxWordCount)}/$maxWordCount words',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: MyColors.blackLight,
                              ),
                            ],
                          ),
                          SB.h(10),
                          Showcase.withWidget(
                            key: _rthree,
                            height: 80,
                            width: 180,
                            disableDefaultTargetGestures:true,
                            tooltipPosition: TooltipPosition.top,
                            targetPadding:const EdgeInsets.all(5),
                            targetBorderRadius : const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            container: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: MyColors.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextSubHeading(
                                        text: AppLocalizations.of(context).translate('addYourReview'),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: MyColors.white,
                                      ),
                                      SB.h(8),
                                      TextSubHeading(
                                        text: AppLocalizations.of(context).translate('shareYourReviewMaximum200Words'),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: MyColors.white,
                                      ),
                                      SB.h(30),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextSubHeading(
                                            text: AppLocalizations.of(context).translate('skip'),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: MyColors.white,
                                            onTap: (){
                                              ShowCaseWidget.of(mContext).completed(_rthree);
                                              addReviewIntroductionStatus(false);
                                            },
                                          ),
                                          SB.w(110),
                                          TextSubHeading(
                                            text: AppLocalizations.of(context).translate('done'),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: MyColors.white,
                                            onTap: (){
                                              ShowCaseWidget.of(mContext).completed(_rthree);
                                              addReviewIntroductionStatus(false);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Positioned(bottom: -20,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: MyColors.primary,
                                    size: 50,
                                  ),
                                ),
                              ],
                            ),
                            child: LargeTextField(
                              controller: homeVM.descriptionController,
                              hintText: AppLocalizations.of(context)
                                  .translate('enterDescriptionUpto200WordsOnly'),
                              isAddMaxWord: true,
                              isEnabled: _isFieldEnabled,
                              disableColor: Colors.white,
                            ),
                          ),
                          SB.h(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                activeColor: MyColors.primary,
                                value: isSelectedCheckbox,
                                onChanged: (value) {
                                  setState(() {
                                    isSelectedCheckbox = value!;
                                  });
                                  print(isSelectedCheckbox);
                                },
                              ), 
                              Expanded(
                                child: Text(AppLocalizations.of(context)
                                    .translate('confirmReview'),),
                              )
                            ],
                          ),
                          SB.h(20),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight > 0 ? keyboardHeight : 15, top: 5,),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<HomeViewModel>(
                builder: (mContext, homeVM, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: PrimaryButton(
                      isDisabled: !isSelectedCheckbox,
                      buttonText: AppLocalizations.of(mContext)
                          .translate('submitReview'),
                      fontWeight: FontWeight.w700,
                      textSize: 16,
                      isLoading: homeVM.isLoading,
                      onPressed: () async {
                        FocusScope.of(mContext).unfocus();
                        var mobile = homeVM.mobileNumberController.text.trim();
                        var name = homeVM.nameController.text.trim();
                        var description = homeVM.descriptionController.text.trim();
                        final localStorage = LocalStorage();
                        final userInfo = await localStorage.getAdditionalUserInfo();
                        var loggedInMobileNumber = userInfo["phoneNo"] ?? "";
                        var loggedInMobileNumberCountryCode = userInfo["countryCode"] ?? "";
                        bool isMobileWithCountryCodeValid = CountryUtils.validatePhoneNumber(mobile, homeVM.selectedCountryCode);
                        var wordCount = description.split(RegExp(r'\s+')).length;
                        if (homeVM.selectedId == 0) {
                          SnackbarManager().showTopSnack(
                            context,
                            AppLocalizations.of(context)
                                .translate('pleaseSelectAnyOfTheFlag'),
                          );
                        } else if (mobile.isEmpty) {
                          SnackbarManager().showTopSnack(
                            context,
                            AppLocalizations.of(context)
                                .translate('phoneNumberCannotBeEmpty'),
                          );
                        }
                        else if (mobile.length < 6) {
                          SnackbarManager().showTopSnack(context, AppLocalizations.of(context).translate('phoneNumberMustBeAtLeastMoreThen5Digits'));
                        }else if (!isMobileWithCountryCodeValid) {
                          SnackbarManager().showTopSnack(
                            context,
                            AppLocalizations.of(context)
                                .translate('phoneNumberInvalidForSelectedCountry'),
                          );
                        }
                        // else if (name.isEmpty) {
                        //   SnackbarManager().showTopSnack(
                        //     context,
                        //     AppLocalizations.of(context)
                        //         .translate('clientNameCannotBeEmpty'),
                        //   );
                        // }
                        else if (name.length > 25) {
                          SnackbarManager().showTopSnack(context, AppLocalizations.of(context).translate('clientNameCannotExceed25Characters'));
                        } else if (description.isEmpty) {
                          SnackbarManager().showTopSnack(
                            context,
                            AppLocalizations.of(context)
                                .translate('descriptionCannotBeEmpty'),
                          );
                        } else if (wordCount > maxWordCount) {
                          SnackbarManager().showTopSnack(
                            context,
                            AppLocalizations.of(context).translate('descriptionCannotExceed250Words'),
                          );
                        }else if (loggedInMobileNumber == mobile && loggedInMobileNumberCountryCode == homeVM.selectedCountryCode) {
                          SnackbarManager().showBottomSnack(
                            context,
                            AppLocalizations.of(context).translate(
                                'youAreLoggedInWithThisNumber'),
                          );
                        } else {
                          homeVM.handleAddReview(
                              mContext,
                            homeVM.selectedCountryCode,
                            mobile,
                           // name,
                            description,
                            homeVM.selectedId,
                            callFrom: widget.callFrom
                          );
                        }
                      },
                    ),
                  );
                },
              ),
              SB.h(5),
              const NetworkStatus(),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   reset();
  //   super.dispose();
  // }

  int _remainingWords = 0;
  int maxWordCount = 200;


  late HomeViewModel homeVM;

  bool _isFieldEnabled = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      var status = prefs.getBool('add_review_intro') ?? true;
      if(status) {
        ShowCaseWidget.of(context).startShowCase([_rone]);
        setState(() {
          _isFieldEnabled=false;
        });
      }

      homeVM = Provider.of<HomeViewModel>(context, listen: false);
      _remainingWords = maxWordCount;
      homeVM.descriptionController.addListener(_updateWordCount);
      reset();
    });
    super.initState();
  }



  addReviewIntroductionStatus(bool isSkipOrDone) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('add_review_intro', isSkipOrDone);
    setState(() {
      _isFieldEnabled=true;
    });
  }


  void _updateWordCount() {
    final text = homeVM.descriptionController.text.trim();
    final wordCount = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    if(mounted) {
      setState(() {
        _remainingWords = maxWordCount - wordCount;
      });
    }
  }

  void reset() async {
    final homeVM = Provider.of<HomeViewModel>(context, listen: false);
    await homeVM.resetAddEditReviewValues();
    if(widget.countryCode.isNotEmpty){
      homeVM.selectedCountryCode = widget.countryCode;
    }
    if(widget.mobile.isNotEmpty){
      homeVM.mobileNumberController.text = widget.mobile;
    }
    if(widget.name.isNotEmpty){
      homeVM.nameController.text = widget.name;
    }


    homeVM.mobileNumberController.addListener(_detectCountryCodeFromInput);
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
