import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/services/shared_service.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/subscription/subscription_select_view_model.dart';

import '../../../locator.dart';
import '../../../model/request/charge_iap_req.dart';
import '../../../services/network_service.dart';
import '../../../utils/image_utils.dart';
import 'subscription_confirm_view.dart';

class SubscriptionSelectView extends StatefulWidget {
  const SubscriptionSelectView({Key? key}) : super(key: key);

  @override
  State<SubscriptionSelectView> createState() => _SubscriptionSelectViewState();
}

const String _kMonthSubscriptionId = 'zimbo_member_1_month';
const List<String> _kProductIds = <String>[
  _kMonthSubscriptionId,
];

class _SubscriptionSelectViewState extends State<SubscriptionSelectView> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = <ProductDetails>[];
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubscriptionSelectViewModel>.reactive(
      viewModelBuilder: () => SubscriptionSelectViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    showLoading();
    final bool isAvailable = await _inAppPurchase.isAvailable();

    if (!isAvailable) {
      setState(() {
        _products = <ProductDetails>[];
        _loading = false;
        hideLoading();
      });
      return;
    }
    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());

    if (productDetailResponse.error != null) {
      setState(() {
        _products = productDetailResponse.productDetails;
        _loading = false;
        hideLoading();
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _products = productDetailResponse.productDetails;
        _loading = false;
        hideLoading();
      });
      return;
    }
    setState(() {
      _products = productDetailResponse.productDetails;
      _loading = false;
      hideLoading();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> consume(String id) async {}

  void showPendingUI() {
    setState(() {});
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {}

  void handleError(IAPError error) {
    setState(() {});
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        hideLoading();
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          if (purchaseDetails.productID == _kMonthSubscriptionId) {
            verifyPurchase(context, purchaseDetails);
          }
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  verifyPurchase(BuildContext context, PurchaseDetails purchaseDetails) async {
    NetworkService networkService = locator<NetworkService>();
    SharedService sharedService = locator<SharedService>();
    String? token = await sharedService.getToken();
    ChargeIapReq req = ChargeIapReq(
        receiptData: purchaseDetails.verificationData.serverVerificationData,
        planId: '1');

    networkService.doChargeIAP(token!, req).then((value) => {
          if (value)
            {
              showMessage(StringUtils.txtSubscriptionSuccessIAP, null),
              SubscriptionConfirmView().launch(context, isNewTask: true),
            }
          else
            {
              showMessage(StringUtils.txtSomethingWentWrong, null),
            }
        });
  }

  Future<void> confirmPriceChange(BuildContext context) async {}

  buildWidget(
      BuildContext context, SubscriptionSelectViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorBlue,
          appBar: AppBar(
            title: textView(StringUtils.txtSubscription,
                textColor: ColorUtils.appColorTextTitle,
                fontSize: SizeUtils.textSizeNormal,
                fontWeight: FontWeight.w500,
                isCentered: true),
            backgroundColor: ColorUtils.appColorWhite,
            centerTitle: true,
            elevation: 0,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            leading: BackButton(
              color: ColorUtils.appColorBlack,
              onPressed: () {
                finishView(context);
              },
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: height * 0.15,
                alignment: Alignment.center,
                child: textView(StringUtils.txtChooseYourPaymentMethod,
                    textColor: ColorUtils.appColorWhite,
                    fontSize: SizeUtils.textSizeXLarge,
                    fontWeight: FontWeight.w600,
                    isCentered: true,
                    maxLine: 2),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    textView(StringUtils.txtFreeTrial,
                        textColor: ColorUtils.appColorWhite,
                        fontSize: SizeUtils.textSizeMedium,
                        fontWeight: FontWeight.w400,
                        isCentered: true),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: width,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              showLoading();
                              if (_products.length > 0) {
                                ProductDetails productDetails = _products[0];
                                late PurchaseParam purchaseParam;
                                purchaseParam = PurchaseParam(
                                  productDetails: productDetails,
                                  applicationUserName: null,
                                );

                                _inAppPurchase.buyNonConsumable(
                                    purchaseParam: purchaseParam);
                              } else {
                                if (_loading) {
                                  showLoading();
                                } else {
                                  hideLoading();
                                  showMessage(
                                      'Subscription item not found', null);
                                }
                              }
                            },
                            child: _loading
                                ? const CircularProgressIndicator(
                                    color: ColorUtils.appColorAccent,
                                  )
                                : textView(
                                    _products.length > 0
                                        ? '${_products[0].price} / Month'
                                        : StringUtils.txt199Month,
                                    textColor: ColorUtils.appColorBlack,
                                    fontSize: SizeUtils.textSizeLarge,
                                    fontWeight: FontWeight.w500,
                                    isCentered: true),
                            style: ElevatedButton.styleFrom(
                                primary: ColorUtils.appColorWhite,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ))),
                      ),
                    ).visible(Platform.isIOS),
                    //.visible(model.isApplePay),
                    Container(
                      width: width,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton.icon(
                            onPressed: () => model.onClickGooglePay(context),
                            icon: SvgPicture.asset(
                              ImageUtils.imgIcGoogle,
                              width: 30,
                              height: 30,
                            ),
                            label: textView(StringUtils.txtPay,
                                textColor: ColorUtils.appColorBlack,
                                fontSize: SizeUtils.textSizeNormal,
                                fontWeight: FontWeight.w500,
                                isCentered: true),
                            style: ElevatedButton.styleFrom(
                                primary: ColorUtils.appColorWhite,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ))),
                      ),
                    ).visible(Platform.isAndroid),
                    Container(
                      width: width,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton.icon(
                            onPressed: () => model.onClickCardPay(context),
                            icon: SvgPicture.asset(
                              ImageUtils.imgIcCard,
                              width: 30,
                              height: 30,
                            ),
                            label: textView(StringUtils.txtPay,
                                textColor: ColorUtils.appColorBlack,
                                fontSize: SizeUtils.textSizeNormal,
                                fontWeight: FontWeight.w500,
                                isCentered: true),
                            style: ElevatedButton.styleFrom(
                                primary: ColorUtils.appColorWhite,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ))),
                      ),
                    ).visible(false),
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap: () {
                            showLoading();
                            _inAppPurchase.restorePurchases();
                          },
                          child: textView(StringUtils.txtRestorePurchase,
                              textColor: ColorUtils.appColorWhite,
                              fontSize: SizeUtils.textSizeMedium,
                              fontWeight: FontWeight.w400,
                              isCentered: true),
                        ).visible(false))
                  ],
                ),
              ),
            ],
          ),
        ),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
