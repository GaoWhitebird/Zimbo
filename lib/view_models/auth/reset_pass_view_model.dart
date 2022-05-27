import 'package:flutter/material.dart';
import 'package:zimbo/model/request/reset_password_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class ResetPassViewModel extends BaseViewModel {
  String? token;
  initialize(BuildContext context, String? _token) async {
    token = _token;
  }

  onClickSend(BuildContext context, String password, String confirmPassword) async {
    if(password.isEmpty){
      showMessage(StringUtils.txtPleaseEnterPassword, null);
      return;
    }
    if(confirmPassword.isEmpty){
      showMessage(StringUtils.txtPasswordNotMatching, null);
      return;
    }
    if(password != confirmPassword){
      showMessage(StringUtils.txtPasswordNotMatching, null);
      return;
    }
    
    if(token == null) return;

    ResetPasswordReq req = ResetPasswordReq(password: password, token: token!);
    await networkService.doResetPassword(req).then((value) => {
      if(value == null){
        showMessage(StringUtils.txtSomethingWentWrong, null),
      }else {
        showMessage(value, null),
        finishView(context),
      }
    });
  }

  onClickRemember(BuildContext context) {
    finishView(context);
  }

}