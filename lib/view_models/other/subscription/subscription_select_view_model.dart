
import 'package:flutter/material.dart';
import 'package:zimbo/view_models/base_view_model.dart';


class SubscriptionSelectViewModel extends BaseViewModel {
  String publishKey = '';
  String? token;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();
  }
}
