
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class SubscriptionSelectViewModel extends BaseViewModel {
  String publishKey ='';
  String? token;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();
    await networkService.doGetStripeKey(token!).then((value) => {
      if(value != null){
        publishKey = value,
        Stripe.publishableKey = publishKey,
      }
    });

    notifyListeners();
  }

}