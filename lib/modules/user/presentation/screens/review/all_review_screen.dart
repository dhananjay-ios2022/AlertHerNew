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
import 'package:alert_her/modules/user/presentation/viewmodels/home_view_model.dart';
import 'package:alert_her/modules/user/presentation/widgets/read_more_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

import '../../../data/models/responses/review_history_response.dart';

class AllReviewScreen extends StatefulWidget {
  final String countryCode;
  final String mobile;
  final String name;

  const AllReviewScreen(
      {super.key,
      this.countryCode = "", //
      this.mobile = "", //
      this.name = ""});

  @override
  State<AllReviewScreen> createState() => _AllReviewScreenState();
}

class _AllReviewScreenState extends State<AllReviewScreen>
    with WidgetsBindingObserver {

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    homeVM.resetReviewValues();
    callAPIs();
    SnackbarManager().showBottomSnack(
        context,backgroundColor: MyColors.green,
        AppLocalizations.of(context).translate('refreshedSuccessfully'),
        duration: const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Consumer<HomeViewModel>(builder: (mContext, homeVM, child) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: Stack(
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
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: SvgPicture.asset(
                                ConstImages.backArrow,
                                height: 28,
                                width: 28,
                              ),
                            ),
                            Image.asset(ConstImages.logo, height: 22, width: 92),
                          ],
                        ),
                        SB.h(70),
                        // Container(
                        //   width: 50,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     color: MyColors.white,
                        //     shape: BoxShape.circle,
                        //     border: Border.all(
                        //       color: getColor(homeVM.topFlag),
                        //       width: 2.5,
                        //     ),
                        //   ),
                        //   child: ClipOval(
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: SvgPicture.asset(
                        //         ConstImages.flag,
                        //         colorFilter: ColorFilter.mode(
                        //             getColor(homeVM.topFlag), BlendMode.srcIn),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SB.h(8),
                        TextHeading(
                          text:
                              "${widget.countryCode.isNotEmpty == true ? widget.countryCode : ''}- ${widget.mobile.isNotEmpty == true ? maskMobile(widget.mobile) : ''}",
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                       // SB.h(5),
                        // TextHeading(
                        //   text: homeVM.lastReviewedName.isNotEmpty == true
                        //       ? capitalizeEachWord(homeVM.lastReviewedName)
                        //       : "",
                        //   fontSize: 20,
                        //   fontWeight: FontWeight.w600,
                        //   color: MyColors.orange,
                        // )
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
                                  "${AppLocalizations.of(context).translate('allReviews')} ${(homeVM.totalReview != 0) ? "(${homeVM.totalReview})" : ""}",
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: MyColors.black,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextHeading(
                                  text: AppLocalizations.of(context)
                                      .translate('addReview'),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: MyColors.primaryDark,
                                  onTap: () async {
                                    final localStorage = LocalStorage();
                                    final userInfo = await localStorage
                                        .getAdditionalUserInfo();
                                    var loggedInMobileNumber =
                                        userInfo["phoneNo"] ?? "";
                                    var loggedInMobileNumberCountryCode =
                                        userInfo["countryCode"] ?? "";
                                    if (loggedInMobileNumber == widget.mobile &&
                                        loggedInMobileNumberCountryCode ==
                                            widget.countryCode) {
                                      SnackbarManager().showBottomSnack(
                                        context,
                                        AppLocalizations.of(context).translate(
                                            'youAreLoggedInWithThisNumber'),
                                      );
                                    } else {
                                      context.push(Routes.addReview, extra: {
                                        'countryCode': widget.countryCode,
                                        'mobile': widget.mobile,
                                        'name': homeVM.lastReviewedName.isNotEmpty ? homeVM.lastReviewedName : widget.name,
                                        'callFrom': "allreview"
                                      });
                                    }
                                  },
                                ),
                                SB.h(5),
                                TextHeading(
                                  text: AppLocalizations.of(context)
                                      .translate('reviewPerDayPerNumber'),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: MyColors.grayDark900,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SB.h(15),
                        if (homeVM.isAllReviewLoading && homeVM.currentPage != 1)
                        LinearProgressIndicator(
                          color: MyColors.primary,
                          backgroundColor: Colors.grey.shade300,
                        ),
                        // if (!homeVM.isAllReviewLoading && homeVM.currentPage < 3)
                          Expanded(
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              // shrinkWrap: false,
                              controller: homeVM.scrollController,
                              itemCount: homeVM.reviewsList.length,
                              itemBuilder: (context, index) {
                                var item = homeVM.reviewsList[index];
                                if (homeVM.isShowOriginalList.length <
                                    homeVM.reviewsList.length) {
                                  homeVM.isShowOriginalList.add(false);
                                }

                                return FutureBuilder<Map<String, dynamic>>(
                                  future:
                                      detectLanguage(item.description ?? ""),
                                  builder: (context, snapshot) {
                                    bool isDifferentLanguage = false;
                                    String translatedText = "";

                                    if (snapshot.hasData) {
                                      var result = snapshot.data!;
                                      isDifferentLanguage =
                                          result["isDifferentLanguage"];
                                      translatedText = result["translatedText"];
                                    }

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
                                                      text:
                                                      AppLocalizations.of(context).translate(
                                                          'Anonymous'),
                                                      // item.reviewerName !=
                                                      //         null
                                                      //     ? capitalizeEachWord(
                                                      //         item.reviewerName!)
                                                      //     : "",
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
                                                      color: MyColors.grayDark900,
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
                                                  text: homeVM.isShowOriginalList[
                                                          index]
                                                      ? translatedText
                                                      : (item.description !=
                                                              null
                                                          ? capitalizeEachWord(
                                                              item.description!)
                                                          : ""),
                                                  textStyle: const TextStyle(
                                                    // fontWeight: FontWeight.w400,
                                                    // fontSize: 13,
                                                    // color: MyColors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                    color: MyColors.black,
                                                    height: 1.4,
                                                  ),
                                                  readMoreStyle:
                                                      const TextStyle(
                                                    // fontWeight: FontWeight.w400,
                                                    // fontSize: 13,
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
                                                if (isDifferentLanguage)
                                                  TextSubHeading(
                                                    text:
                                                        homeVM.isShowOriginalList[
                                                                index]
                                                            ? "Show Original"
                                                            : "Translate Review",
                                                    color: MyColors.primaryDark,
                                                    underline: true,
                                                    underlineColor:
                                                        MyColors.primaryDark,
                                                    underlineThickness: 0.5,
                                                    onTap: () {
                                                      setState(() {
                                                        homeVM.isShowOriginalList[
                                                            index] = !homeVM
                                                                .isShowOriginalList[
                                                            index];
                                                      });
                                                    },
                                                  ),
                                                SB.h(10),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if(item.isEditable!)
                                              GestureDetector(
                                                onTap: () {
                                                  context.push(Routes.editReview,
                                                      extra: {
                                                        'id':item.id,
                                                        'countryCode':widget.countryCode,
                                                        'mobile': widget.mobile,
                                                        'name': item.clientName ?? '',
                                                        'flag': item.flag,
                                                        'description': item.description ?? '',
                                                        'isCallFromHome': false
                                                      });
                                                },
                                                child: SvgPicture.asset(
                                                  height: 24,
                                                  width: 24,
                                                  ConstImages.edit,
                                                ),
                                              ),
                                              if(item.isReportable!)
                                              SB.h(30),
                                              if(item.isReportable!)
                                              GestureDetector(
                                                child: SvgPicture.asset(
                                                  height: 24,
                                                  width: 24,
                                                  ConstImages.info,
                                                ),
                                                onTap: () {
                                                  homeVM
                                                      .resetReportDailogValues();
                                                  List<String> reportType = [
                                                    AppLocalizations.of(context)
                                                        .translate('select'),
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'reportReview'),
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'reportUser'),
                                                  ];
                                                  DialogManager()
                                                      .showReportDialog(
                                                    report:
                                                        item.reviewedBy ?? "",
                                                    id: item.id ?? "",
                                                    reportType: reportType,
                                                    context: context,
                                                  );
                                                },
                                              ),
                                              if(!item.isReportable!)
                                                SB.h(30),
                                              if(!item.isReportable!)
                                                GestureDetector(
                                                  child: SvgPicture.asset(
                                                    height: 26,
                                                    width: 26,
                                                    ConstImages.removeReport,
                                                  ),
                                                  onTap: () {
                                                    DialogManager()
                                                        .showDeleteReportDialog(
                                                        heading: AppLocalizations.of(context).translate('deleteReport'),
                                                        subHeading: AppLocalizations.of(context).translate('areYouSureYouWantToDeleteReport'),
                                                        context: context,
                                                      onButtonPressed: (){
                                                        print(item.id);
                                                        homeVM.deleteReview(context, item.id!, item);
                                                      }
                                                    );
                                                  },
                                                )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        if (homeVM.isAllReviewLoading && homeVM.currentPage == 1)
                          Expanded(
                            child: Visibility(
                              visible: homeVM.isAllReviewLoading,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CupertinoActivityIndicator(
                                    radius: 10.0,
                                    color: MyColors.primary,
                                  ),
                                  SB.h(10),
                                  TextHeading(
                                    text: AppLocalizations.of(context)
                                        .translate('reviewListIsLoading'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: MyColors.blackLight,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (!homeVM.isAllReviewLoading &&
                            homeVM.reviewsList.isEmpty)
                          Expanded(
                            child: Visibility(
                              visible: homeVM.isAllReviewLoading,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextHeading(
                                    text: AppLocalizations.of(context)
                                        .translate('noReviewFound'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: MyColors.blackLight,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        bottomNavigationBar: const NetworkStatus(),
      ),
    );
  }

  late HomeViewModel homeVM;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeVM = Provider.of<HomeViewModel>(context, listen: false);
      callAPIs();
    });
  }


  void callAPIs() async {
    await homeVM.reviewHistory(context, widget.countryCode, widget.mobile);
    homeVM.scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    final homeVM = Provider.of<HomeViewModel>(context, listen: false);
    if (homeVM.scrollController.position.pixels >=
        homeVM.scrollController.position.maxScrollExtent - 20) {
      await homeVM.reviewHistory(context, widget.countryCode, widget.mobile);
    }
  }

  Future<Map<String, dynamic>> detectLanguage(String text) async {
    final translator = GoogleTranslator();
    try {
      String savedLanguage = await LocalStorage().getSelectedLanguage() ?? "en";
      if (savedLanguage == "zh") {
        savedLanguage = "zh-cn";
      }
      final detectedLanguage =
          await translator.translate(text, to: savedLanguage);
      var language = detectedLanguage.sourceLanguage;

      if (language.code == "auto" || language.code == language) {
        return {"isDifferentLanguage": false, "translatedText": ""};
      }

      return {
        "isDifferentLanguage":
            (language.code.contains(savedLanguage)) ? false : true,
        "translatedText":
            (language.code.contains(savedLanguage)) ? "" : detectedLanguage.text
      };
    } catch (e) {
      print("Error in language detection: $e");
      return {"isDifferentLanguage": false, "translatedText": ""};
    }
  }
}
