import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/subscription/subscription_select_view_model.dart';

import '../../../utils/image_utils.dart';

class SubscriptionSelectView extends StatefulWidget {
  const SubscriptionSelectView({Key? key}) : super(key: key);

  @override
  State<SubscriptionSelectView> createState() => _SubscriptionSelectViewState();
}

const bool _kAutoConsume = true;

const String _kGoldSubscriptionId = 'zimbo_subscription_1_month';
const List<String> _kProductIds = <String>[
  _kGoldSubscriptionId,
];

class _SubscriptionSelectViewState extends State<SubscriptionSelectView> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

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
    final bool isAvailable = await _inAppPurchase.isAvailable();

    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = [];
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  _buildProductList() {
    if (_loading) {
      return;
    }
    if (!_isAvailable) {
      return;
    }
    const ListTile productHeader = ListTile(title: Text('Products for Sale'));
    final List<ListTile> productList = <ListTile>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: const Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    final Map<String, PurchaseDetails> purchases =
        Map<String, PurchaseDetails>.fromEntries(
            _purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));

    return;
  }

  Future<void> consume(String id) async {}

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {}

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
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
              GestureDetector(
                child: Container(
                  height: height * 0.1,
                  alignment: Alignment.center,
                  child: textView(StringUtils.txt199Month,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeLarge,
                      fontWeight: FontWeight.w600,
                      isCentered: true,
                      maxLine: 2),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: width,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
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
                                showMessage(
                                    'Subscription item not found', null);
                              }
                            },
                            child: textView(StringUtils.txtSubscribeForZimbo,
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
                    ),
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap: () {
                            _inAppPurchase.restorePurchases();
                          },
                          child: textView(StringUtils.txtRestorePurchase,
                              textColor: ColorUtils.appColorWhite,
                              fontSize: SizeUtils.textSizeMedium,
                              fontWeight: FontWeight.w400,
                              isCentered: true),
                        ).visible(Platform.isIOS))
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
