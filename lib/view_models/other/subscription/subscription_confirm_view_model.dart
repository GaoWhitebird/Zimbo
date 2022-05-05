
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/subscription/keychain_confirm_view.dart';

class SubscriptionConfirmViewModel extends BaseViewModel {
  
  initialize(BuildContext context) async {

  }

  onClickSubmit(BuildContext context) async {
    finishView(context);
    const KeychainConfirmView().launch(context);
  }

}