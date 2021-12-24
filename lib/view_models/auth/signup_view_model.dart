import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/services/common_service.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zimbo/views/auth/select_item_view.dart';

class SignUpViewModel extends BaseViewModel{
  String name = '';
  String email = '';
  String password = '';

  initialize(BuildContext context) async {

  }

  onClickBack(BuildContext context) {
    finishView(context);
  }

  onClickFacebookLogin(BuildContext context) {}

  onClickGoogleLogin(BuildContext context) {}

  onClickSignUp(BuildContext context) {
    const SelectItemView().launch(context);
  }

  onClickCondition(BuildContext context) {
    launchURL(CommonService.conditionsUrl);
  }

  onClickTerms(BuildContext context) {
    launchURL(CommonService.termsUrl);
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      
    }
  }
}