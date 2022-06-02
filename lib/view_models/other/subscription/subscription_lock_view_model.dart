
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/subscription/subscription_select_view.dart';

import '../../../views/other/subscription/subscription_confirm_view.dart';

class SubscriptionLockViewModel extends BaseViewModel{
  UserModel? userModel;
  initialize(BuildContext context) async {
    userModel = await sharedService.getUser();
    notifyListeners();
  }

  onClickContinue(BuildContext context) {
    const SubscriptionSelectView().launch(context);
  }

  onClickContinueFree(BuildContext context) {
    SubscriptionConfirmView().launch(context,);
  }
  
}