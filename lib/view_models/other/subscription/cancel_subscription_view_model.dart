
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/subscription_info_model.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/model/request/cancel_subscription_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/subscription/edit_subscription_view.dart';
import 'package:zimbo/views/other/subscription/subscription_history_view.dart';
import 'package:zimbo/views/other/subscription/subscription_lock_view.dart';

class CancelSubscriptionViewModel extends BaseViewModel {
  SubscriptionInfoModel? subscriptionInfoModel;
  String? token;
  UserModel? userModel;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();
    userModel = await sharedService.getUser();
    subscriptionInfoModel = userModel!.subscriptionInfo;

    await networkService.doGetSubscriptionInfo(token!).then((value) => {
      if(value != null){
        subscriptionInfoModel = value,

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

  onClickCancelPayment(BuildContext context) async {
    CancelSubscriptionReq req = CancelSubscriptionReq(stripeSubscriptionId: subscriptionInfoModel!.stripeSubscriptionId!);
    await networkService.doCancelSubscription(token!, req).then((value) => {
      if(value){
        showMessage(StringUtils.txtSubscriptionCancel, null),

        const SubscriptionLockView().launch(context, isNewTask: true),
      }
    });
  }
}