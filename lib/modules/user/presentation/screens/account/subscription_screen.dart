import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/core/utils/string_extension.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/api_const.dart';
import '../../../../../core/services/local_shared_prefs.dart';
import '../../../../../core/services/local_storage.dart';
import '../../../../../core/services/snackbar_manager.dart';
import '../../../../../core/utils/app_utils.dart';
import '../../../../../core/utils/date_utils.dart';
import '../../../data/models/responses/local_subscription_response.dart';
import '../../../data/models/responses/login_response.dart';
import '../../../data/models/responses/registration_response.dart';
import '../../viewmodels/subscription_view_model.dart';

class SubscriptionScreen extends StatefulWidget {
  final String callFrom;

  const SubscriptionScreen({super.key, required this.callFrom});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final localStorage = LocalStorage();
  var subscriptionStatus = false;
  String subId = '';
  String subTitle = '';
  String subDes = '';
  String subCurrencyCode = '';
  String subCurrencySymbol = '';
  int subDuration = 0;
  String subPrice = '';
  dynamic subRawPrice = 0.0;
  String subDurationType = '';
  DateTime? subStart;
  String formattedStartDate = '';
  DateTime? subEnd;
  String formattedEndDate = '';
  DateTime? currentDate;
  int remainingDays = 0;
  SharedPref sharedPref = SharedPref();
  SubscriptionProvider subscription = SubscriptionProvider();
  @override
  void initState() {
    super.initState();

    //! Here in this screen we will called purchaseInit();
    //! And this is inside initState so it will called one time only
    //! and this will provide products details
    //! we used "WidgetsBinding.instance.addPostFrameCallback" because we want to used context in provider
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        callAPI();
      },
    );
  }

  callAPI() {
    subscription = context.read<SubscriptionProvider>();
    /// Init Store -> Get available product from store
    /// call purchaseInit -> get storeInfo
    setState(() {
      subscription.purchaseInit(context);
      subscription.isActive.then((value) {
        print("yes:::: $value");
        getSubscriptionData();
      },);
    });
    // subscription.subscription.listen(
    //   (event) {
    //     debugPrint('listenCalled');
    //   },
    //   onDone: () {},
    //   onError: (_) {},
    // );
  }

  getSubscriptionData() async {
      String? jsonString = await sharedPref.read(
          "user"); // Get the stored JSON String
      if (jsonString != null) {
        Map<String, dynamic> jsonData = json.decode(
            jsonString); //  Convert String to Map
        LocalSubscriptionResponse loginData = LocalSubscriptionResponse.fromJson(jsonData); // Now pass the Map
        print(loginData);
        subscriptionStatus = loginData.subscriptionStatus ?? false;
        subId =
            loginData.planId ?? subscription.currentActivePlanId;
        subTitle = loginData.title ?? '';
        subDes = loginData.description ?? '';
        subCurrencyCode = loginData.currencyCode ?? '';
        subCurrencySymbol = loginData.currencySymbol ?? '';
        subDuration = loginData.duration ?? 0;
        subPrice = loginData.price ?? '';
        subRawPrice = loginData.rawPrice ?? 0.0;
        subDurationType = loginData.durationType ?? '';
        subStart =
            DateTime.parse(loginData.subscriptionStart.toString()).toLocal();
        subEnd = DateTime.parse(loginData.subscriptionEnd.toString()).toLocal();
        currentDate = DateTime.now();
        final difference = daysBetween(currentDate!, subEnd!);
        var remaining = difference;
        remainingDays = remaining;
        print("remaining days : $remainingDays");
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final subscriptionProvider = context.watch<SubscriptionProvider>();
    final products = subscriptionProvider.productDetails;

    print("_products ios: ${products.length}");
    print("subscriptionStatus : $subscriptionStatus");
    print("subId : $subId");
    print("subTitle : $subTitle");
    print("subDes : $subDes");
    print("subCurrencyCode : $subCurrencyCode");
    print("subCurrencySymbol : $subCurrencySymbol");
    print("subDuration : $subDuration");
    print("subPrice : $subPrice");
    print("subRawPrice : $subRawPrice");
    print("subDurationType : $subDurationType");
    print("subStart : $subStart");
    print("subEnd : $subEnd");
    print("remaining days : $remainingDays");

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: MyColors.primaryLight,
                padding: const EdgeInsets.only(top: 25, left: 17, right: 15),
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
                          .translate('subscriptionPlan'),
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
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child:
                // subscriptionProvider.isLoading
                //     ? const Center(child: CircularProgressIndicator())
                //     :
                Consumer<SubscriptionProvider>(
                    builder: (mContext, subscribeVM, child) {
                    return subscribeVM.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          :
                      SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SB.h(5),
                                (subscriptionStatus)
                                    ? TextHeading(
                                        text: AppLocalizations.of(context)
                                            .translate('activePlan'),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: MyColors.black,
                                      )
                                    :
                                TextHeading(
                                        text: AppLocalizations.of(context)
                                            .translate('selectPlan'),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: MyColors.grayDark900,
                                      ),
                                SB.h(25),
                                // Container(
                                //   height: size.height * 0.09,
                                //   width: size.width,
                                //   decoration: const BoxDecoration(
                                //       borderRadius:
                                //           BorderRadius.all(Radius.circular(18)),
                                //       image: DecorationImage(
                                //           image: AssetImage(
                                //             "assets/images/Frame_1.png",
                                //           ),
                                //           fit: BoxFit.cover)),
                                //   child: Padding(
                                //     padding:
                                //         const EdgeInsets.symmetric(horizontal: 15),
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         TextHeading(
                                //           text: AppLocalizations.of(context)
                                //               .translate('freeTrial'),
                                //           fontWeight: FontWeight.w500,
                                //           fontSize: 18,
                                //           color: MyColors.black,
                                //         ),
                                //         SizedBox(
                                //           width: size.width * 0.24,
                                //           height: size.height * 0.04,
                                //           child: PrimaryButton(
                                //             buttonText: AppLocalizations.of(context)
                                //                 .translate('active'),
                                //             bgColor: Colors.white,
                                //             textColor: MyColors.primary,
                                //             radius: 10,
                                //             onPressed: () {},
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                Column(
                                  children: [
                                    Container(
                                      height: (subTitle != "Free Trial") ? size.height * 0.15 : size.height * 0.14,
                                      width: size.width,
                                      decoration: const BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(18)),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                "assets/images/Frame_1.png",
                                              ),
                                              fit: BoxFit.cover)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                (subTitle != "Free Trial") ?
                                                Text(
                                                  subPrice,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    fontFamily: 'roboto',
                                                    color: MyColors.black,
                                                  ),
                                                ): Container(),
                                                SB.h(10),
                                                TextHeading(
                                                  text: subTitle,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                  color: MyColors.black,
                                                ),
                                                SB.h(10),
                                                Text(
                                                  subDes,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 8,
                                                    fontFamily: 'roboto',
                                                    color: MyColors.black,
                                                  ),
                                                ),
                                                const Expanded(child: SizedBox()),
                                                (remainingDays <= 0)?
                                                SizedBox(
                                                  width: size.width * 0.25,
                                                  height: size.height * 0.03,
                                                  child: PrimaryButton(
                                                    buttonText: AppLocalizations.of(
                                                        context)
                                                        .translate(
                                                        'expired'),
                                                    bgColor: MyColors.orange300,
                                                    textSize: 8,
                                                    fontWeight: FontWeight.w500,
                                                    radius: 10,
                                                    onPressed: () {
                                                      showErrorSnackbar(
                                                          context,
                                                          AppLocalizations.of(context)
                                                              .translate('planIsExpired'));
                                                    },
                                                  )):
                                                (remainingDays > 0 && remainingDays <= 6 ) ?
                                                SizedBox(
                                                  width: size.width * 0.4,
                                                  height: size.height * 0.03,
                                                  child: PrimaryButton(
                                                    buttonText: AppLocalizations.of(
                                                        context)
                                                        .translate(
                                                        'Your Plan will expire within $remainingDays days'),
                                                    bgColor: MyColors.orange300,
                                                    textSize: 8,
                                                    fontWeight: FontWeight.w500,
                                                    radius: 10,
                                                    onPressed: () {},
                                                  ),
                                                ):
                                                    Container()
                                              ],
                                            ),
                                            // SizedBox(
                                            //   width: size.width * 0.27,
                                            //   height: size.height * 0.04,
                                            //   child: PrimaryButton(
                                            //     buttonText: AppLocalizations.of(context)
                                            //         .translate('changePlan'),
                                            //     bgColor: Colors.white,
                                            //     textColor: MyColors.primary,
                                            //     radius: 10,
                                            //     onPressed: () {},
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SB.h(25),
                                    (subTitle == "Free Trial" || subscriptionStatus == false)?
                                    Container():
                                    PrimaryButton(
                                      buttonText: AppLocalizations.of(context)
                                          .translate('cancelPlan'),
                                      onPressed: () {
                                        Platform.isAndroid ?
                                        AppUtils.launchThisURL(context,
                                            "${ApiConst.cancelAndroid}sku=$subId&package=com.app.alerther"):
                                        AppUtils.launchThisURL(context,ApiConst.cancelIos);
                                      },
                                    ),
                                  ],
                                ),
                                (subTitle == "Free Trial" || subscriptionStatus == false)? SB.h(15): SB.h(25),
                                SizedBox(
                                  height: size.height * 0.45,
                                  width: size.width,
                                  child: GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                      itemCount: products.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 1.1,
                                              mainAxisSpacing: 15,
                                              crossAxisSpacing: 15,
                                              crossAxisCount: 2),
                                      itemBuilder: (_, index) {
                                        var pro = products[index];
                                        return PlanList(
                                          imagePath: (index == 0 ||
                                                  index == 3 ||
                                                  index == 4)
                                              ? "assets/images/Frame_2.png"
                                              : "assets/images/Frame_3.png",
                                          price: pro.price,
                                          duration: '',
                                          planName: pro.title,
                                          description: pro.description,
                                          buttonDesign: (subId == pro.id)?
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: TextHeading(
                                              text: AppLocalizations.of(context)
                                                  .translate('activePlan'),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: MyColors.primary,
                                            ),
                                          ):
                                          PrimaryButton(
                                            buttonText: AppLocalizations.of(context).translate('buyNow'),
                                            bgColor: Colors.white,
                                            textColor: MyColors.primary,
                                            radius: 10,
                                            onPressed: () async {
                                              await subscriptionProvider
                                                  .buyProduct(
                                                product:
                                                pro, // pass index base on your logic
                                              );
                                            }
                                          ),
                                          // },
                                        );
                                      }
                                      //   },
                                      ),
                                ),
                                // SB.h(15),
                                // TextHeading(
                                //   text: AppLocalizations.of(context)
                                //       .translate('activePlan'),
                                //   fontWeight: FontWeight.w500,
                                //   fontSize: 18,
                                //   color: MyColors.black,
                                // ),
                                SB.h(100),
                                // _isAvailable
                                //     ? Column(
                                //   children: [
                                //     ElevatedButton(
                                //       onPressed: _getSubscriptionList,
                                //       child: Text('Get Subscriptions'),
                                //     ),
                                //   ],
                                // )
                                //     : Text('In-App Purchases are not available on this device.'),

                                // _isAvailable
                                //     ? Column(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     if (_products.isEmpty)
                                //       Center(
                                //         child: Text('No products available.'),
                                //       )
                                //     else
                                //       ..._products.map((product) => ListTile(
                                //         title: Text(product.title),
                                //         subtitle: Text(product.description),
                                //         trailing: ElevatedButton(
                                //           onPressed: () => _buySubscription(product),
                                //           child: Text('Buy (${product.price})'),
                                //         ),
                                //       )),
                                //     SizedBox(height: 20),
                                //     ElevatedButton(
                                //       onPressed: _restorePurchases,
                                //       child: Text('Restore Purchases'),
                                //     ),
                                //   ],
                                // )
                                //     : Center(
                                //   child: Text('In-app purchases are not available on this device.'),
                                // ),
                                if(subId == '')
                                PrimaryButton(
                                  buttonText: AppLocalizations.of(context)
                                      .translate('restorePlan'),
                                  onPressed: () {
                                    subscriptionProvider.restorePlan(context);
                                  },
                                ),
                                SB.h(20),

                              ],
                            ),
                          );
                  }
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const NetworkStatus(),
      ),
    );
  }

  void showErrorSnackbar(
      BuildContext context,
      String message, {
        Color backgroundColor = Colors.red,
        bool isTop = true
      }) {
    if(isTop) {
      SnackbarManager().showTopSnack(
          context, message, backgroundColor: backgroundColor);
    }else{
      SnackbarManager().showBottomSnack(
          context, message, backgroundColor: backgroundColor);
    }
  }

}

class PlanList extends StatelessWidget {
  final String imagePath;
  final String price;
  final String duration;
  final String planName;
  final String description;
  final Widget? buttonDesign;
  const PlanList(
      {required this.imagePath,
      required this.price,
      required this.duration,
      required this.planName,
      required this.description,
        this.buttonDesign,
      super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: MyColors.gray,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          image: DecorationImage(image: AssetImage(imagePath))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextHeading(
                  text: price,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: MyColors.black,
                ),
                TextHeading(
                  text: duration,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: MyColors.grayDark900,
                ),
              ],
            ),
            SB.h(8),
            Text(
              planName,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                fontFamily: 'roboto',
                color: MyColors.black,
              ),
            ),
            SB.h(8),
            Text(
              description,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 8,
                fontFamily: 'roboto',
                color: MyColors.black,
              ),
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              width: size.width,
              height: size.height * 0.04,
              child: buttonDesign,
            )
          ],
        ),
      ),
    );
  }
}
