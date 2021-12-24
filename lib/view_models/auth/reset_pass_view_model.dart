import 'package:flutter/material.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class ResetPassViewModel extends BaseViewModel {
  
  initialize(BuildContext context) async {

  }

  onClickSend(BuildContext context) {}

  onClickRemember(BuildContext context) {
    finishView(context);
  }

}