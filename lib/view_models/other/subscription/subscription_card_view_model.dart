
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/time_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

import '../../../views/other/subscription/edit_subscription_card_view.dart';
import '../../../views/other/subscription/subscription_history_view.dart';

class SubscriptionCardViewModel extends BaseViewModel {
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
    final result = await EditSubscriptionCardView().launch(context, isNewTask: false);
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