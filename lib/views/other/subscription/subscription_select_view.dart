import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/subscription/subscription_select_view_model.dart';

class SubscriptionSelectView extends StatelessWidget {
  const SubscriptionSelectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubscriptionSelectViewModel>.reactive(
      viewModelBuilder: () => SubscriptionSelectViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, SubscriptionSelectViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    const _paymentItems = [
      PaymentItem(
        label: 'monthly',
        amount: '1.99',
        status: PaymentItemStatus.final_price,
      )
    ];
    Pay _payClient = Pay.withAssets([
      'apple_pay.json',
      'google_pay.json'
    ]);

    void onGooglePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    void onApplePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

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
              RawGooglePayButton(
                style: GooglePayButtonStyle.white,
                type: GooglePayButtonType.pay,
                onPressed: () async {
                    final result = await _payClient.showPaymentSelector(
                                        provider: PayProvider.google_pay,
                                        paymentItems: _paymentItems,
                                      );
                }),
              GooglePayButton(
                paymentConfigurationAsset: 'google_pay.json',
                paymentItems: _paymentItems,
                style: GooglePayButtonStyle.white,
                type: GooglePayButtonType.pay,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              ApplePayButton(
                paymentConfigurationAsset: 'apple_pay.json',
                paymentItems: _paymentItems,
                style: ApplePayButtonStyle.white,
                type: ApplePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onApplePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
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
