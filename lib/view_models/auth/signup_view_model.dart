import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/request/signup_email_req.dart';
import 'package:zimbo/services/common_service.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zimbo/views/auth/select_item_view.dart';

class SignUpViewModel extends BaseViewModel {
  String name = '';
  String email = '';
  String password = '';
  String? deviceKey = '';

  initialize(BuildContext context) async {
    deviceKey = await getDeviceId();
  }

  onClickBack(BuildContext context) {
    finishView(context);
  }

  onClickFacebookLogin(BuildContext context) {}

  onClickGoogleLogin(BuildContext context) {}

  onClickSignUp(BuildContext context, String _name, String _email,
      String _password) async {
    name = _name.trim();
    email = _email.trim();
    password = _password;

    if (checkValidate()) {
      SignUpEmailReq req = SignUpEmailReq(
          userName: name,
          email: email,
          password: password,
          deviceKey: deviceKey ?? '');

      await networkService.doSignUpEmail(req).then((value) => {
            if (value != null)
              {
                sharedService.saveUser(value),
                const SelectItemView().launch(context, isNewTask: true),
              }
          });
    }
  }

  onClickCondition(BuildContext context) {
    launchURL(CommonService.termsUrl);
  }

  onClickPrivacy(BuildContext context) {
    launchURL(CommonService.privacyUrl);
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  bool checkValidate() {
    if (name.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterName, null);
      return false;
    }
    if (email.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterEmail, null);
      return false;
    }
    if (password.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterPassword, null);
      return false;
    }
    if (!isValidEmail(email)) {
      showMessage(StringUtils.txtPleaseEnterCorrectEmail, null);
      return false;
    }
    if (!isValidPassword(password)) {
      showMessage(StringUtils.txtPleaseEnterCorrectPassword, null);
      return false;
    }
    return true;
  }
}
