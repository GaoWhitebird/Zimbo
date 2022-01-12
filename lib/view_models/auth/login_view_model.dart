import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/request/login_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/auth/reset_pass_view.dart';
import 'package:zimbo/views/auth/signup_view.dart';
import 'package:zimbo/views/main/main_view.dart';

class LoginViewModel extends BaseViewModel {
  String email = '';
  String password = '';
  String? deviceKey = '';

  initialize(BuildContext context) async {
    deviceKey = await getDeviceId();
  }

  onClickFacebookLogin(BuildContext context) {
    notifyListeners();
  }

  onClickGoogleLogin(BuildContext context) {
    notifyListeners();
  }

  onClickLogin(BuildContext context, String _email, String _password) async {
    email = _email.trim();
    password = _password;

    if (checkValidate()) {
      LoginReq req = LoginReq(
          email: email, password: password, deviceKey: deviceKey ?? '');

      await networkService.doLogin(req).then((value) => {
            if (value != null)
              {
                sharedService.saveUser(value),
                const MainView().launch(context, isNewTask: true),
              }
          });
    }
  }

  onClickRegister(BuildContext context) {
    SignUpView().launch(context, isNewTask: false);
  }

  onClickResetPass(BuildContext context) {
    ResetPassView().launch(context, isNewTask: false);
  }

  bool checkValidate() {
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
