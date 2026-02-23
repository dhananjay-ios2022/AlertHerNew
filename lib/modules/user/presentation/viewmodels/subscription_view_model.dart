import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

import '../../../../core/constants/my_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/services/dialog_manager.dart';
import '../../../../core/services/local_shared_prefs.dart';
import '../../../../core/services/local_storage.dart';
import '../../../../core/services/snackbar_manager.dart';
import '../../../../core/utils/api_response.dart';
import '../../../../localizations/app_localizations.dart';
import '../../data/models/requests/subscription_request.dart';
import '../../data/models/responses/add_subscription_response.dart';
import '../../data/models/responses/base_response.dart';
import '../../data/repositories/home_repository.dart';

class SubscriptionProvider extends ChangeNotifier {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final HomeRepository homeRepository = HomeRepository();

  //! Private variables
  bool _available = false;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  bool _isLoading = false;
  bool isAddSubscriptionLoading = false;
  bool isAllNotificationLoading = false;
  // final StreamController<StreamSubscription<List<PurchaseDetails>>> _processCompletionController = StreamController<StreamSubscription<List<PurchaseDetails>>>();
  final StreamController<Stream<List<PurchaseDetails>>>
      _processCompletionController =
      StreamController<Stream<List<PurchaseDetails>>>();

  //! Getters

  //! used for loading until process competition
  bool get isLoading => _isLoading;
  //! If we want use stream outside of this provider we can used it
  //! but used here or there not both side
  //! for best state-management we used inside this provider class
  Stream<Stream<List<PurchaseDetails>>> get subscription =>
      _processCompletionController.stream;
  //! isAvailable provide boolean for is product available or not
  bool get isAvailable => _available;
  List<ProductDetails> get productDetails => _products;
  List<PurchaseDetails> get purchaseDetails => _purchases;
  //! This 'isActive' bool will provider my plan is active or not in anywhere in any screen
  Future<bool> get isActive async => await _isSubscriptionActive();

  //! Find product are available in store or not
  //! this method will called onetime for trigger stream and get details about
  //! available product
  Future<void> purchaseInit(context) async {
    try {
      _purchaseStream(context);
      _isLoading = true;
      notifyListeners();
      _available = await _inAppPurchase.isAvailable();
      debugPrint('_available : $_available');
      notifyListeners();
      final productIDs = <String>{
        'com.app.alerther_monthly_plan',
        'com.app.alerther_quaterly_plan',
        'com.app.alerther_half_yearly_plan',
        'com.app.alerther_yearly_plan',
      }; // your productIDs
      debugPrint('productIDs : $productIDs');
      List<ProductDetails> products = await _getProducts(productIDs);
      _products = products;
      _products.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
      _isSubscriptionActive();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('catchError : $e');
    }
  }

  //! This stream will triggered every time when any change will occur in purchase plan,
  //! or user will buy/restore purchase plan

  StreamSubscription<List<PurchaseDetails>> _purchaseStream(context) {
    final Stream<List<PurchaseDetails>> purchaseUpdate =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdate.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList, context);
        _purchases = purchaseDetailsList;
        notifyListeners();
      },
      onDone: () {
        _subscription?.cancel();
        const SnackBar(content: Text("Done"));
        // Fluttertoast.showToast(msg: "Done");
      },
      onError: (e) {
        _subscription?.cancel();
        SnackBar(content: Text("Error : $e"));
        // Fluttertoast.showToast(msg: "Error : $_");
      },
    );
    notifyListeners();

    _processCompletionController.sink.add(purchaseUpdate);
    return _subscription!;
  }

  //! This function will provide products with details
  //! If no product available then list provide empty list

  Future<List<ProductDetails>> _getProducts(Set<String> productIDs) async {
    ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(productIDs);
    debugPrint('_getProductsError : ${response.error}');
    return response.productDetails;
  }

  // ! This function will call from outside for buy product
  // ! whichever purchasePlan/product want to buy will passed as function argument
  // ! if user/consumer/customer buy our any purchase plan then this will true otherwise false
  // ! Must Note : in below function autoConsume = false for android and true for ios
  bool isSuccess = false;
  late PurchaseParam purchaseParam;
  bool isLoadingBuy = false;
  Future<bool> buyProduct({required ProductDetails product}) async {
    purchaseParam = PurchaseParam(productDetails: product);
    isSuccess = await _inAppPurchase.buyNonConsumable(
      purchaseParam: purchaseParam,
    );

    debugPrint('buyProduct : isSuccess => $isSuccess');
    debugPrint('buyProduct : => ${purchaseParam.applicationUserName}');
    debugPrint('id : => ${purchaseParam.productDetails.id}');
    debugPrint('title : => ${purchaseParam.productDetails.title}');
    debugPrint('price : => ${purchaseParam.productDetails.price}');
    debugPrint('rawprice : => ${purchaseParam.productDetails.rawPrice}');
    debugPrint(
        'currencycode : => ${purchaseParam.productDetails.currencyCode}');
    debugPrint(
        'currencySymbol : => ${purchaseParam.productDetails.currencySymbol}');
    debugPrint('des : => ${purchaseParam.productDetails.description}');
    debugPrint('id : => ${purchaseParam.productDetails.id}');

    return isSuccess;
  }

  //! In case of app uninstalled or something happening then
  //! if plan is still active so user no need to buy new plan
  //! user can restore previous plan if exist and still active
  //! This function also called from outside for restoring purpose
  //! in below method 'response.pastPurchases.isEmpty' is true thats mean no plan is active
  //! base on that you can move ahead in your app

  Future restorePlan(context) async {
    debugPrint('restorePlan');
    await _inAppPurchase.restorePurchases();
    final response = await _inAppPurchase
        .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>()
        .queryPastPurchases();

    if (response.pastPurchases.isEmpty) {
      showErrorSnackbar(context,
          AppLocalizations.of(context).translate('doNotHaveRestorePlan'));
    } else {
      await _inAppPurchase.completePurchase(purchaseDetails.last);
      showErrorSnackbar(context,
          AppLocalizations.of(context).translate('planRestoreSuccessfully'));
    }
  }

  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList, context) {
    purchaseDetailsList.forEach(
      (PurchaseDetails purchaseDetails) async {
        debugPrint('_status : ${purchaseDetails.status}');
        debugPrint('purchaseID : ${purchaseDetails.purchaseID}');
        debugPrint('transactionDate : ${purchaseDetails.transactionDate}');
        debugPrint('productID : ${purchaseDetails.productID}');
        debugPrint(
            'localVerificationData : ${purchaseDetails.verificationData.localVerificationData}');
        debugPrint(
            'serverVerificationData : ${purchaseDetails.verificationData.serverVerificationData}');
        debugPrint('source : ${purchaseDetails.verificationData.source}');

        debugPrint('_Error  : ${purchaseDetails.error}');
        switch (purchaseDetails.status) {
          case PurchaseStatus.canceled:
            {
              showErrorSnackbar(context,
                  AppLocalizations.of(context).translate('cancelledPayment'));
            }
            break;
          case PurchaseStatus.pending:
            {
              const SnackBar(
                  content: Text("Your subscription plan is pending"));
            }
            break;
          case PurchaseStatus.purchased:
            {
              handleAddSubscription(
                  context,
                  purchaseParam.productDetails.id,
                  purchaseParam.productDetails.rawPrice,
                  purchaseParam.productDetails.price,
                  purchaseDetails.transactionDate.toString(),
                  purchaseDetails.purchaseID ?? '');
            }
            break;
          case PurchaseStatus.restored:
            {
              // Restore purchases, if applicable.
              final response = await _inAppPurchase
                  .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>()
                  .queryPastPurchases();
              if (response.pastPurchases.isNotEmpty) {
                await _inAppPurchase.completePurchase(purchaseDetails);
                showErrorSnackbar(
                    context,
                    AppLocalizations.of(context)
                        .translate('planRestoreSuccessfully'));
              }
            }
            break;
          case PurchaseStatus.error:
            {
              debugPrint('----Error : ${purchaseDetails.error}');
              debugPrint('----msg   : ${purchaseDetails.error?.message}');
              if (purchaseDetails.error!.message ==
                  "BillingResponse.itemAlreadyOwned") {
                showErrorSnackbar(
                    context,
                    AppLocalizations.of(context)
                        .translate('alreadyPurchasedThisPlan'));
                Future.delayed(const Duration(seconds: 2, milliseconds: 200),
                    () {
                  const SnackBar(content: Text("Try to restore your plan"));
                });
              } else if (purchaseDetails.error!.message ==
                  "BillingResponse.developerError") {
                showErrorSnackbar(context, purchaseDetails.error?.details);
                SnackBar(content: Text(purchaseDetails.error?.details));
              } else if (purchaseDetails.error!.message ==
                  "BillingResponse.itemUnavailable") {
                showErrorSnackbar(context,
                    AppLocalizations.of(context).translate('planUnavailable'));
              }
            }
            break;
          default:
            {
              showErrorSnackbar(context,
                  AppLocalizations.of(context).translate('somethingWentWrong'));
            }
            break;
        }

        debugPrint(
            '====> purchaseDetails.pendingCompletePurchase : ${purchaseDetails.pendingCompletePurchase}');
        if (purchaseDetails.pendingCompletePurchase) {
          print(purchaseDetails.transactionDate);
          await _inAppPurchase.completePurchase(purchaseDetails);
          //StoreData locally
          // final encode = SubscriptionsInfo.toJson(purchaseDetails);
          // sharedPref.subscriptionInfo = encodeSubscriptionInfo(SubscriptionsInfo.fromJson(encode));
        }
      },
    );
    notifyListeners();
  }

  String currentActivePlanId = '';

  Future<void> handleAddSubscription(
      BuildContext context,
      String subscriptionId,
      double subscriptionRawPrice,
      String subscriptionPrice,
      String subscriptionStart,
      String purchaseID) async {
    if (!await isInternetAvailable(context)) return;

    isAddSubscriptionLoading = true;
    notifyListeners();

    final platform = Platform.isAndroid ? "android" : "ios";
    final subscriptionRequest = SubscriptionRequest(
      subscriptionId: subscriptionId,
      subscriptionRawPrice: subscriptionRawPrice,
      subscriptionPrice: subscriptionPrice,
      subscriptionStart: subscriptionStart,
      purchaseID: purchaseID,
      platform: platform,
    );

    try {
      ApiResponse<GetSubscriptionResponse> repoRes =
          await homeRepository.subscriptionRepo(subscriptionRequest);
      if (repoRes.statusCode == 200 || repoRes.statusCode == 201) {
        isAddSubscriptionLoading = false;
        var res = repoRes.body?.data;
        print("sub price 4::::+++++ ${res?.subscriptionPrice.toString()}");
        SnackbarManager().showTopSnack(
            context,
            backgroundColor: MyColors.green,
            AppLocalizations.of(context).translate('purchasePlanSuccessfully'));
        SharedPref().save('user', json.encode(res));
        // await LocalStorage().saveSubscribeInfo(
        //   id: res?.subscription?.planId,
        //   des: res?.subscription?.description,
        //   price: res?.subscriptionPrice.toString(),
        //   title: res?.subscription?.title,
        //   rawPrice: res?.subscriptionRawPrice.toString(),
        //   currencyCode: res?.subscription?.currencyCode,
        //   currencySymbol: res?.subscription?.currencySymbol,
        //   durationType: res?.subscription?.durationType,
        //   duration: res?.subscription?.duration.toString(),
        //   subStart: res?.subscriptionStart.toString(),
        //   subEnd: res?.subscriptionEnd.toString(),
        //   subStatus: res?.subscriptionStatus.toString(),
        // );
        currentActivePlanId = res?.subscription?.planId ?? '';
        context.push(Routes.home);
        notifyListeners();
      } else {
        isAllNotificationLoading = false;
        notifyListeners();
        switch (repoRes.statusCode) {
          case 404:
            showErrorSnackbar(
                context,
                AppLocalizations.of(context)
                    .translate('oopsSomethingWentWrong'));
            break;
          case 400:
            showErrorSnackbar(
                context,
                AppLocalizations.of(context)
                    .translate('invalidRequestPleaseCheckYourInternet'));
            break;
          case 402:
            DialogManager().showBlockDialog(context: context);
            break;
          case 500:
            showErrorSnackbar(
                context,
                AppLocalizations.of(context)
                    .translate('weCouldNotCompleteYourRequestRightNow'));
            break;
          default:
            showErrorSnackbar(context,
                AppLocalizations.of(context).translate('somethingWentWrong'));
            break;
        }
      }
    } catch (_) {
      showErrorSnackbar(
        context,
        AppLocalizations.of(context)
            .translate('weCouldNotCompleteYourRequestRightNow'),
      );
    }

    isAddSubscriptionLoading = false;
    notifyListeners();
  }

  Future<bool> isInternetAvailable(BuildContext context,
      {Function? onRetry}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      bool isNetworkConnected = connectivityResult != ConnectivityResult.none;

      if (isNetworkConnected) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            return true;
          } else {
            showErrorSnackbar(context,
                AppLocalizations.of(context).translate('noInternetConnection'));
            return false;
          }
        } on SocketException catch (_) {
          showErrorSnackbar(context,
              AppLocalizations.of(context).translate('noInternetConnection'));
          return false;
        }
      } else {
        showErrorSnackbar(context,
            AppLocalizations.of(context).translate('noInternetConnection'));
        return false;
      }
    } catch (e) {
      showErrorSnackbar(
          context,
          AppLocalizations.of(context)
              .translate('somethingWentWrongInYourInternetConnection'));
      return false;
    }
  }

  //! This function will help when app will open then we check my subscription is active
  //! If plan is active this will provide true other wise provide false
  //! Base on true/false we move ahead in our app

  Future<bool> _isSubscriptionActive() async {
    QueryPurchaseDetailsResponse? response;
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      response = await androidAddition.queryPastPurchases();
      notifyListeners();
    }
    debugPrint('isSubscriptionActive Error : ${response?.error?.message}');

    //! if get an error no plan is active we send false
    if (response?.error != null) return false;
    debugPrint(
        'isSubscriptionActive responseList : ${response?.pastPurchases}');

    //! if list is empty that mean no plan is active
    //! there for we return false
    if (response!.pastPurchases.isEmpty) {
      return false;
    } else {
      response.pastPurchases.forEach(
        (_) {
          debugPrint('status =====> ${_.status}');
          debugPrint(
              'pendingCompletePurchase =====> ${_.pendingCompletePurchase}');
          debugPrint('productID =====> ${_.productID}');
          debugPrint('transactionDate =====> ${_.transactionDate}');
          debugPrint(
              'transactionDate Parsed =====> ${DateTime.fromMillisecondsSinceEpoch(int.parse(_.transactionDate!))}');
          debugPrint('purchaseID ====> ${_.purchaseID}');
          debugPrint(
              'purchaseID ====> ${_.billingClientPurchase.originalJson}');
        },
      );

      return true;
    }
  }

  void showErrorSnackbar(BuildContext context, String message,
      {Color backgroundColor = Colors.red, bool isTop = true}) {
    if (isTop) {
      SnackbarManager()
          .showTopSnack(context, message, backgroundColor: backgroundColor);
    } else {
      SnackbarManager()
          .showBottomSnack(context, message, backgroundColor: backgroundColor);
    }
  }
}
