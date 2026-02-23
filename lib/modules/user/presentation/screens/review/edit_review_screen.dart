import 'package:alert_her/core/comman_widgets/large_text_field.dart';
import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/normal_text_field.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/app_strings.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
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

class EditReviewScreen extends StatefulWidget {
  final String id;
  final String countryCode;
  final String mobile;
  final String name;
  final String description;
  final int flag;
  final bool isCallFromHome;

  const EditReviewScreen({
    super.key,
    this.id = "",
    this.countryCode = "",
    this.mobile = "",
    this.name = "",
    this.description = "",
    this.flag = 0,
    this.isCallFromHome = true,
  });

  @override
  State<EditReviewScreen> createState() => _EditReviewScreenState();
}

class _EditReviewScreenState extends State<EditReviewScreen> {
  List<Map<String, dynamic>> _getFlagItems(BuildContext context) {
    return [
      {
        'borderColor': MyColors.green,
        'bgColor': MyColors.greenLight,
        'text': AppLocalizations.of(context).translate('genuineGood'),
        'id': 1,
      },
      {
        'borderColor': MyColors.green500,
        'bgColor': MyColors.greenLight100,
        'text': AppLocalizations.of(context).translate('generalNeutral'),
        'id': 2,
      },
      {
        'borderColor': MyColors.yellow,
        'bgColor': MyColors.yellowLight,
        'text': AppLocalizations.of(context).translate('timeWaisterNoShow'),
        'id': 3,
      },
      {
        'borderColor': MyColors.orange500,
        'bgColor': MyColors.orangeLight100,
        'text': AppLocalizations.of(context)
            .translate('violenceDangerousRobberyAvoid'),
        'id': 4,
      },
      {
        'borderColor': MyColors.red,
        'bgColor': MyColors.redLight,
        'text': AppLocalizations.of(context)
            .translate('fraudulentLandlordAgentOfficer'),
        'id': 5,
      },
    ];
  }

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
                              .translate('editReview'),
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
                                final isSelected = homeVM.selectedIndex == index;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      homeVM.selectedIndex = index;
                                      homeVM.selectedId = item['id'];
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
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
                                isEnable: false,
                                onCountrySelected: (String code) {},
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
                                    isEnabled: false,
                                    disableColor: MyColors.primaryLight,
                                    disableTextColor: MyColors.black,
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
                          // NormalTextField(
                          //   height: 50,
                          //   controller: homeVM.nameController,
                          //   hintText: AppLocalizations.of(context)
                          //       .translate('enterName'),
                          //   inputType: TextInputType.text,
                          // ),
                          // SB.h(15),
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
                          LargeTextField(
                            controller: homeVM.descriptionController,
                            hintText: AppLocalizations.of(context)
                                .translate('enterDescriptionUpto200WordsOnly'),
                            isAddMaxWord: true,
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
                      buttonText: AppLocalizations.of(context)
                          .translate('updateReview'),
                      fontWeight: FontWeight.w700,
                      textSize: 16,
                      isLoading: homeVM.isLoading,
                      onPressed: () {
                       // var name = homeVM.nameController.text.trim();
                        var description = homeVM.descriptionController.text.trim();
                        var wordCount = description.split(RegExp(r'\s+')).length;
                        // if (name.isEmpty) {
                        //   SnackbarManager().showTopSnack(
                        //     context,
                        //     AppLocalizations.of(context)
                        //         .translate('clientNameCannotBeEmpty'),
                        //   );
                        // }else
                        //   if (name.length > 25) {
                        //   SnackbarManager().showTopSnack(context, AppLocalizations.of(context).translate('clientNameCannotExceed25Characters'));
                        // } else
                          if (description.isEmpty) {
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
                        }else {
                          homeVM.handleEditReview(
                            context,
                            widget.id,
                           // name,
                            description,
                            homeVM.selectedId,
                            isCallFromHome: widget.isCallFromHome,
                            mobile: widget.mobile,
                              countryCode: widget.countryCode
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeVM = Provider.of<HomeViewModel>(context, listen: false);
      _remainingWords = maxWordCount;
      homeVM.descriptionController.addListener(_updateWordCount);
      reset();
    });
    super.initState();
  }

  void _updateWordCount() {
    final text = homeVM.descriptionController.text.trim();
    final wordCount = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    if (mounted) {
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
    // if(widget.name.isNotEmpty){
    //   homeVM.nameController.text = widget.name;
    // }
    if(widget.description.isNotEmpty){
      homeVM.descriptionController.text = widget.description;
    }

    if(widget.flag != 0) {
      final _flagItems = _getFlagItems(context);
      if (_flagItems.isNotEmpty) {
        homeVM.selectedIndex = widget.flag - 1; // Default to the first item
        homeVM.selectedId = _flagItems[widget.flag - 1]['id'];
      }
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
