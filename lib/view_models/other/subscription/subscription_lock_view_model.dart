
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/subscription/subscription_select_view.dart';

class SubscriptionLockViewModel extends BaseViewModel{
  
  initialize(BuildContext context) async {

  }

  onClickContinue(BuildContext context) {
    const SubscriptionSelectView().launch(context);
  }
  
}