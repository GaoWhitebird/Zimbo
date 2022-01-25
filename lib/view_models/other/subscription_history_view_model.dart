
import 'package:flutter/material.dart';
import 'package:zimbo/model/common/payment_history_item_model.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class SubscriptionHistoryViewModel extends BaseViewModel {

  List<PaymentHistoryItemModel> mList = [];
  String? token;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();

    await networkService.doGetPaymentHistory(token!).then((value) => {
      if(value != null) {
        mList = value,
        notifyListeners(),
      }
    });
  }

}