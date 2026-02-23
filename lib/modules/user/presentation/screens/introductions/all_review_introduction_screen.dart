import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/app_config.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/routes/routes.dart';
import 'package:alert_her/core/services/dialog_manager.dart';
import 'package:alert_her/core/services/local_storage.dart';
import 'package:alert_her/core/services/snackbar_manager.dart';
import 'package:alert_her/core/utils/date_utils.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/core/utils/string_extension.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/data/models/responses/review_history_response.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/home_view_model.dart';
import 'package:alert_her/modules/user/presentation/widgets/read_more_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:translator/translator.dart';


GlobalKey _one = GlobalKey();
GlobalKey _two = GlobalKey();
GlobalKey _three = GlobalKey();

class AllReviewIntroductionScreen extends StatefulWidget {
  final String countryCode;
  final String mobile;
  final String name;

  const AllReviewIntroductionScreen(
      {super.key,
        this.countryCode = "", //
        this.mobile = "", //
        this.name = ""});

  @override
  State<AllReviewIntroductionScreen> createState() => _AllReviewIntroductionScreenState();
}

class _AllReviewIntroductionScreenState extends State<AllReviewIntroductionScreen> with WidgetsBindingObserver {

  List<Review> recentReviewsList = [
    Review(
      id: "1",
      countryCode: "+1",
      mobile: "1234567890",
      flag: 1,
      clientName: "John Doe",
      description: "Excellent service and quick response.",
      reviewedBy: "Admin",
      isActive: true,
      createdAt: "2024-12-01T10:00:00Z",
      updatedAt: "2024-12-02T12:00:00Z",
      isEditable: true,
      isReportable: false,
      reviewerName: "John Reviewer",
      v: 0,
    ),
    Review(
      id: "2",
      countryCode: "+44",
      mobile: "9876543210",
      flag: 2,
      clientName: "Jane Smith",
      description: "总体体验良好，但仍有改进空间",
      reviewedBy: "Moderator",
      isActive: true,
      createdAt: "2024-12-05T15:00:00Z",
      updatedAt: "2024-12-05T16:00:00Z",
      isEditable: false,
      isReportable: true,
      reviewerName: "Jane Reviewer",
      v: 0,
    ),
    Review(
      id: "3",
      countryCode: "+91",
      mobile: "1122334455",
      flag: 3,
      clientName: "Raj Kumar",
      description: "The service was satisfactory and met expectations.",
      reviewedBy: "User",
      isActive: true,
      createdAt: "2024-12-10T08:00:00Z",
      updatedAt: "2024-12-11T09:00:00Z",
      isEditable: false,
      isReportable: true,
      reviewerName: "Raj Reviewer",
      v: 1,
    ),
  ];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
        ShowCaseWidget.of(context).startShowCase([_one]);
    });
  }


  reviewIntroductionStatus(bool isSkipOrDone) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('review_intro', isSkipOrDone);
    var homeVM = Provider.of<HomeViewModel>(context,listen: false);
    homeVM.resetSearchValues();
    homeVM.resetReviewValues();
    context.pushReplacement(
        Routes.allReview,
        extra: {
          'countryCode': widget.countryCode ?? "",
          'mobile': widget.mobile ?? "",
          'name': widget.name ?? ""
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Consumer<HomeViewModel>(builder: (mContext, homeVM1, child) {
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ConstImages.backArrow,
                            height: 28,
                            width: 28,
                          ),
                          Image.asset(ConstImages.logo, height: 22, width: 92),
                        ],
                      ),
                      SB.h(20),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: getColor(1),
                            width: 2.5,
                          ),
                        ),
                        child: ClipOval(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              ConstImages.flag,
                              colorFilter: ColorFilter.mode(
                                  getColor(1), BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ),
                      SB.h(8),
                      const TextHeading(
                        text:
                            "+44- 1234567***",
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      SB.h(5),
                      const TextHeading(
                        text: "Micheal",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: MyColors.orange,
                      )
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: 220,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SB.h(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHeading(
                            text:
                                "${AppLocalizations.of(context).translate('allReviews')} (3)",
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: MyColors.black,
                          ),
                          Showcase.withWidget(
                            key: _one,
                            height: 80,
                            width: 180,
                            disableDefaultTargetGestures:true,
                            targetPadding:const EdgeInsets.all(5),
                            targetBorderRadius : const BorderRadius.all(
                              Radius.circular(4),
                            ),
                            container: Stack(
                              children: [
                                const Positioned(
                                  top:-20,
                                  right: 20,
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
                                        text: AppLocalizations.of(context).translate('addReviewWithOutPlus'),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: MyColors.white,
                                      ),
                                      SB.h(8),
                                      TextSubHeading(
                                        text: AppLocalizations.of(context).translate('toAddANewReviewForThisContactNumberYouAreAllowedToSubmit'),
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
                                              ShowCaseWidget.of(context).completed(_one);
                                              reviewIntroductionStatus(false);
                                            },
                                          ),
                                          //SB.w(110),
                                          TextSubHeading(
                                            text: AppLocalizations.of(context).translate('next'),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: MyColors.white,
                                            onTap: (){
                                              ShowCaseWidget.of(context).startShowCase([_two]);
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
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextHeading(
                                    text: AppLocalizations.of(context)
                                        .translate('addReview'),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: MyColors.primaryDark,
                                  ),
                                  SB.h(5),
                                  TextHeading(
                                    text: AppLocalizations.of(context).translate('reviewPerDayPerNumber'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: MyColors.grayDark900,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SB.h(15),
                        Expanded(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: recentReviewsList.length,
                            itemBuilder: (context, index) {
                              var item = recentReviewsList[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: MyColors.grayLight,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              TextSubHeading(
                                                text: item.reviewerName !=
                                                    null
                                                    ? capitalizeEachWord(
                                                    item.reviewerName!)
                                                    : "",
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w600,
                                                color: MyColors.orange,
                                              ),
                                              SB.w(8),
                                              TextSubHeading(
                                                text: item.updatedAt !=
                                                    null
                                                    ? formatDateString(
                                                    item.updatedAt!)
                                                    : "",
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.w400,
                                                color: MyColors.grayDark,
                                              ),
                                              SB.w(5),
                                              Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  color: MyColors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: getColor(
                                                        item.flag ?? 0),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: ClipOval(
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(3.0),
                                                    child:
                                                    SvgPicture.asset(
                                                      ConstImages.flag,
                                                      colorFilter:
                                                      ColorFilter
                                                          .mode(
                                                        getColor(
                                                            item.flag ??
                                                                0),
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SB.h(12),
                                          ReadMoreText(
                                            text: capitalizeEachWord(item.description!),
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: MyColors.black,
                                              height: 1.4,
                                            ),
                                            readMoreStyle:
                                            const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: MyColors.primaryDark,
                                              height: 1.4,
                                              decoration: TextDecoration
                                                  .underline,
                                            ),
                                            maxLines: 3,
                                          ),
                                          SB.h(10),
                                          item.id == "2" ?
                                          Showcase.withWidget(
                                            key: _three,
                                            height: 80,
                                            width: 180,
                                            disableDefaultTargetGestures:true,
                                            targetPadding:const EdgeInsets.all(5),
                                            targetBorderRadius : const BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                            container: Stack(
                                              children: [
                                                const Positioned(
                                                  top:-20,
                                                  left: 20,
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
                                                        text: AppLocalizations.of(context).translate('translateReview'),
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 14,
                                                        color: MyColors.white,
                                                      ),
                                                      SB.h(8),
                                                      TextSubHeading(
                                                        text: AppLocalizations.of(context).translate('toTranslateToReviewToYourPreferenceLanguage'),
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
                                                              ShowCaseWidget.of(context).completed(_three);
                                                              reviewIntroductionStatus(false);
                                                            },
                                                          ),
                                                          SB.w(110),
                                                          TextSubHeading(
                                                            text: AppLocalizations.of(context).translate('done'),
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 12,
                                                            color: MyColors.white,
                                                            onTap: (){
                                                              ShowCaseWidget.of(context).completed(_three);
                                                              reviewIntroductionStatus(false);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            child: const TextSubHeading(
                                              text:  "Translate Review",
                                              color: MyColors.primaryDark,
                                              underline: true,
                                              underlineColor:
                                              MyColors.primaryDark,
                                              underlineThickness: 0.5,
                                            ),
                                          ) : Container(),

                                          SB.h(10),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        if(item.isEditable! && index == 0)
                                          Showcase.withWidget(
                                            key: _two,
                                            height: 80,
                                            width: 180,
                                            disableDefaultTargetGestures:true,
                                            targetPadding:const EdgeInsets.all(5),
                                            targetBorderRadius : const BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                            container: Stack(
                                              children: [
                                                const Positioned(
                                                  top:-20,
                                                  right: 30,
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
                                                        text: AppLocalizations.of(context).translate('editYourReview'),
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 14,
                                                        color: MyColors.white,
                                                      ),
                                                      SB.h(8),
                                                      TextSubHeading(
                                                        text: AppLocalizations.of(context).translate('toEditYourReviewForThisContactNumber'),
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
                                                              ShowCaseWidget.of(context).completed(_two);
                                                              reviewIntroductionStatus(false);
                                                            },
                                                          ),
                                                          SB.w(110),
                                                          TextSubHeading(
                                                            text: AppLocalizations.of(context).translate('next'),
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 12,
                                                            color: MyColors.white,
                                                            onTap: (){
                                                              ShowCaseWidget.of(context).startShowCase([_three]);
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
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: SvgPicture.asset(
                                                height: 24,
                                                width: 24,
                                                ConstImages.edit,
                                              ),
                                            ),
                                          ),

                                        if(item.isReportable!)
                                          SB.h(30),
                                        if(item.isReportable! && index == 2)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: SvgPicture.asset(
                                              height: 24,
                                              width: 24,
                                              ConstImages.info,
                                            ),
                                          ),

                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
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






}
