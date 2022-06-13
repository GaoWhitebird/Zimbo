import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/request/charge_google_req.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/subscription/edit_subscription_card_view.dart';
import 'package:zimbo/views/other/subscription/subscription_confirm_view.dart';

import '../../../utils/string_utils.dart';

class SubscriptionSelectViewModel extends BaseViewModel {
  bool isGooglePay = false;
  bool isApplePay = false;
  String publishKey = '';
  String? token;
  final paymentItems = [
    const PaymentItem(
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
    String jsonStringGoogle = '';

    PaymentConfiguration paymentConfigurationGoogle;
    PaymentConfiguration paymentConfigurationApple;
    List<PaymentConfiguration> configurations;

    await networkService.doGetPaymentMethodInfo(token!).then((value) async => {
          if (value != null)
            {
              publishKey = value,
              googlePayJsonStr = await DefaultAssetBundle.of(context)
                  .loadString("assets/pay/google_pay.json"),
              applePayJsonStr = await DefaultAssetBundle.of(context)
                  .loadString("assets/pay/apple_pay.json"),
              configurations = <PaymentConfiguration>[],
              if (publishKey.contains("pk_live"))
                {
                  jsonStringGoogle =
                      googlePayJsonStr.replaceAll("TEST", "PRODUCTION"),
                },
              jsonStringGoogle =
                  googlePayJsonStr.replaceAll("pk_key", publishKey),
              paymentConfigurationGoogle =
                  PaymentConfiguration.fromJsonString(jsonStringGoogle),
              paymentConfigurationApple =
                  PaymentConfiguration.fromJsonString(applePayJsonStr),
              configurations.add(paymentConfigurationGoogle),
              configurations.add(paymentConfigurationApple),
              payClient = Pay(configurations),
              payClient!.userCanPay(PayProvider.google_pay).then(
                    (value) => {
                      isGooglePay = value,
                      notifyListeners(),
                    },
                  ),
              payClient!.userCanPay(PayProvider.apple_pay).then(
                    (value) => {
                      isApplePay = value,
                      notifyListeners(),
                    },
                  ),
              notifyListeners(),
            }
        });
  }

  onClickGooglePay(BuildContext context) async {
    try {
      final result = await payClient!.showPaymentSelector(
          provider: PayProvider.google_pay, paymentItems: paymentItems);

      var paymentMethodData = result["paymentMethodData"];
      var tokenizationData = paymentMethodData["tokenizationData"];
      var tokenData = tokenizationData["token"];
      tokenData = jsonDecode(tokenData);
      var id = tokenData["id"];

      if (id.isNotEmpty) {
        ChargeGoogleReq req = ChargeGoogleReq(txnId: id, planId: '1');
        networkService.doChargeGoogle(token!, req).then((value) => {
              if (value)
                {
                  showMessage(StringUtils.txtSubscriptionSuccess, null),
                  SubscriptionConfirmView().launch(context, isNewTask: true),
                }
              else
                {
                  showMessage(StringUtils.txtSomethingWentWrong, null),
                }
            });
      }
    } catch (e) {
      if (e is PlatformException) {
        showMessage(
            e.message == null ? StringUtils.txtSomethingWentWrong : e.message!,
            null);
      }
    }
  }

  onClickApplePay(BuildContext context) async {
    
  }

  onClickCardPay(BuildContext context) {
    EditSubscriptionCardView().launch(context);
  }
}
