import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/routes/routes.dart';
import 'package:alert_her/core/services/local_storage.dart';
import 'package:alert_her/core/utils/date_utils.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/core/utils/string_extension.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

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
    await homeVM.notificationHistory(context);
    homeVM.scrollNotificationController.addListener(_onScroll);
  }

  void _onScroll() async {
    final homeVM = Provider.of<HomeViewModel>(context, listen: false);
    if (homeVM.scrollNotificationController.position.pixels >=
        homeVM.scrollNotificationController.position.maxScrollExtent - 20) {
      await homeVM.notificationHistory(context);
    }
  }

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
                            text: AppLocalizations.of(context).translate('notification'),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SB.h(5),
                          if(!homeVM.isAllNotificationLoading && homeVM.notificationList.isNotEmpty)
                          Row(
                            children: [
                              TextHeading(
                                text: AppLocalizations.of(context).translate('allNotification'),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: MyColors.black,
                              ),
                            ],
                          ),
                          if (homeVM.isAllNotificationLoading && homeVM.currentNotificationPage != 1)
                            LinearProgressIndicator(
                              color: MyColors.primary,
                              backgroundColor: Colors.grey.shade300,
                            ),
                          // if(!homeVM.isAllNotificationLoading && homeVM.currentNotificationPage != 2)
                          Expanded(
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: homeVM.scrollNotificationController,
                              itemCount: homeVM.notificationList.length,
                              itemBuilder: (context, index) {
                                var item = homeVM.notificationList[index];
                                return GestureDetector(
                                  onTap: () async {
                                    if(item.type == 1) {
                                      final prefs = await SharedPreferences.getInstance();
                                      var status = prefs.getBool('review_intro') ?? true;
                                      if (status == true) {
                                        context.push(Routes.allReviewIntro,
                                            extra: {
                                              'countryCode': item.countryCode ?? "",
                                              'mobile': item .mobile ?? ""
                                            });
                                      } else {
                                        context.push(Routes.allReview, extra: {
                                          'countryCode': item.countryCode,
                                          'mobile': item.mobile
                                        });
                                      }
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              height: 45,
                                              width: 45,
                                              ConstImages.notificationBell,
                                            ),
                                            SB.w(8),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextSubHeading(
                                                    text: item.description !=
                                                        null
                                                        ? capitalizeEachWord(
                                                        item.description!)
                                                        : "",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: MyColors.black,
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  SB.h(8),
                                                  TextSubHeading(
                                                    text: item.createdAt !=
                                                        null
                                                        ? formatDateTime(item.createdAt!)
                                                        : "",
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    color: MyColors.grayDark,
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: MyColors.gray,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          if (homeVM.isAllNotificationLoading && homeVM.currentNotificationPage == 1)
                            Expanded(
                              child: Visibility(
                                visible: homeVM.isAllNotificationLoading,
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
                                          .translate('notificationListIsLoading'),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: MyColors.blackLight,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (!homeVM.isAllNotificationLoading && homeVM.notificationList.isEmpty)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextHeading(
                                    text: AppLocalizations.of(context)
                                        .translate('notificationListIsEmpty'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: MyColors.blackLight,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          // Expanded(
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Center(
                          //         child: TextHeading(
                          //           text: AppLocalizations.of(context)
                          //               .translate('notificationListIsEmpty'),
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 16,
                          //           color: MyColors.blackLight,
                          //           textAlign: TextAlign.center,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

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
