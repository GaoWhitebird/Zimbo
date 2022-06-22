import 'package:flutter/material.dart';
import 'package:zimbo/model/request/forgot_password_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class ForgotPassViewModel extends BaseViewModel {
  
  initialize(BuildContext context) async {

  }

  onClickSend(BuildContext context, String email) async {
    if(email.isNotEmpty){
      email = email.trim();
    }
    
    if(email.isNotEmpty && isValidEmail(email)){
      ForgotPasswordReq req = ForgotPasswordReq(email: email);
      await networkService.doForgotPassword(req).then((value) => {
        if(value == null){
          showMessage(StringUtils.txtSomethingWentWrong, null),
        }else {
          showMessage(value, null),
          finishView(context),
        }
      });
    }else {
      showMessage(StringUtils.txtPleaseEnterCorrectEmail, null);
    }
  }

  onClickRemember(BuildContext context) {
    finishView(context);
  }

}