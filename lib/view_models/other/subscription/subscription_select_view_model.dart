
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

import '../../../views/other/subscription/subscription_card_view.dart';

class SubscriptionSelectViewModel extends BaseViewModel {
  bool isGooglePay = true;
  bool isApplePay = true;
  String publishKey ='';
  String? token;
  static const paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '1.99',
        status: PaymentItemStatus.final_price,
      )
      ];
  Pay? payClient;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();
    String googlePayJsonStr = '';
    String applePayJsonStr = '';
    Map googlePayJson;
    Map applePayJson;
    PaymentConfiguration paymentConfigurationGoogle;
    PaymentConfiguration paymentConfigurationApple;
    List<PaymentConfiguration> configurations;

    var data;
    var allowedPaymentMethods;
    var tokenizationSpecification;
    var parameters;

    await networkService.doGetStripeKey(token!).then((value) async => {
      if(value != null){
        publishKey = value,

        googlePayJsonStr = await DefaultAssetBundle.of(context).loadString("assets/pay/google_pay.json"),
        applePayJsonStr = await DefaultAssetBundle.of(context).loadString("assets/pay/apple_pay.json"),
        googlePayJson = json.decode(googlePayJsonStr),
        applePayJson = json.decode(applePayJsonStr),
        
        data = googlePayJson['data'],
        allowedPaymentMethods = data['allowedPaymentMethods'],
        tokenizationSpecification = allowedPaymentMethods[0]['tokenizationSpecification'],
        parameters = tokenizationSpecification['parameters'],
        parameters.update('stripe:publishableKey', (value) => publishKey),

        tokenizationSpecification['parameters'] = parameters,
        tokenizationSpecification = allowedPaymentMethods[0]['tokenizationSpecification'] = tokenizationSpecification['parameters'],
        data['allowedPaymentMethods'] = allowedPaymentMethods,
        googlePayJson['data'] = data,

        configurations = <PaymentConfiguration>[],
        paymentConfigurationGoogle = PaymentConfiguration.fromJsonString(json.encode(googlePayJson)),
        paymentConfigurationApple = PaymentConfiguration.fromJsonString(json.encode(applePayJson)),
        configurations.add(paymentConfigurationGoogle),
        configurations.add(paymentConfigurationApple),
        
        payClient = Pay(configurations),
        payClient!.userCanPay(PayProvider.google_pay).then((value) => {
          isGooglePay = value,
        },),
        payClient!.userCanPay(PayProvider.apple_pay).then((value) => {
          isApplePay = value,
        },),

        notifyListeners(),
      }
    });
  }

  onClickGooglePay(BuildContext context) async {
    final result = await payClient!.showPaymentSelector(
      provider: PayProvider.google_pay,
      paymentItems: [],
    );

    showMessage(result.toString(), null);
  }

  onClickApplePay(BuildContext context) async {
    final result = await payClient!.showPaymentSelector(
          provider: PayProvider.apple_pay,
          paymentItems: [],
        );

    showMessage(result.toString(), null);
  }

  onClickCardPay(BuildContext context) {
    const SubscriptionCardView().launch(context);
  }

}