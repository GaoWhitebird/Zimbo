import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/auth/reset_pass_view.dart';
import 'package:zimbo/views/auth/signup_view.dart';

class LoginViewModel extends BaseViewModel {
  String email = '';
  String password = '';
  
  initialize(BuildContext context) async{

  }

  onClickFacebookLogin(BuildContext context){
    notifyListeners();
  }

  onClickGoogleLogin(BuildContext context){
    notifyListeners();
  }

  onClickLogin(BuildContext context){
    notifyListeners();
  }

  onClickRegister(BuildContext context){
    SignUpView().launch(context, isNewTask: false);
  }

  onClickResetPass(BuildContext context) {
    ResetPassView().launch(context, isNewTask: false);
  }

}