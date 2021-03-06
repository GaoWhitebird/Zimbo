
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/subscription/edit_subscription_view.dart';
import 'package:zimbo/views/other/subscription/subscription_history_view.dart';

import '../../../model/common/subscription_info_model.dart';
import '../../../model/common/user_model.dart';
import '../../../model/request/cancel_subscription_req.dart';

class SubscriptionViewModel extends BaseViewModel {
  SubscriptionInfoModel? subscriptionInfoModel;
  String? token;
  UserModel? userModel;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();
    userModel = await sharedService.getUser();
    subscriptionInfoModel = userModel!.subscriptionInfo;
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
    CancelSubscriptionReq req = CancelSubscriptionReq(stripeSubscriptionId: subscriptionInfoModel!.stripeSubscriptionId!);
    await networkService.doCancelSubscription(token!, req).then((value) => {
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