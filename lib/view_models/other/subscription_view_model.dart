
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/time_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/edit_subscription_view.dart';
import 'package:zimbo/views/other/subscription_history_view.dart';

class SubscriptionViewModel extends BaseViewModel {
  bool isSubscription = false;
  bool hasHistory = false;
  String nextDate = '';
  String subscriptionCost = '\$10';
  String? token;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();

    await networkService.doGetSubscriptionInfo(token!).then((value) => {
      if(value != null){
        isSubscription = value.isSubscription == '1',
        hasHistory = value.isHistory == '1',
        nextDate = readTimestampYYYYDD(value.nextDay),
        subscriptionCost = '\$' + value.cost, 

        notifyListeners(),
      }
    });
  }

  void onClickAddCard(BuildContext context) async {
    final result = await EditSubscriptionView().launch(context, isNewTask: false);
    if (result != null && result){
      initialize(context);
    }
    notifyListeners();
  }

  void onClickHistory(BuildContext context) {
    const SubscriptionHistoryView().launch(context, isNewTask: false);
  }

  void onClickCancelPayment(BuildContext context) async {
    await networkService.doCancelPayment(token!).then((value) => {
      if(value){
        showMessage(StringUtils.txtSubscriptionCancel, null),

        initialize(context),
      }else {
        showMessage(StringUtils.txtSubscriptionCancelFailed, null),
      }
    });
  }

  void onClickEdit(BuildContext context) {
    onClickAddCard(context);
  }

}