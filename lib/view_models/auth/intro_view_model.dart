import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/auth/login_view.dart';

class IntroViewModel extends BaseViewModel {
  int currentIndex = 0;
  PageController pageController = PageController();
  List<String> buttonTextList = [StringUtils.txtNext, StringUtils.txtNext, StringUtils.txtStartScanning];

  initialize(BuildContext context) async {

  }

  onClickPrev() {
    if (currentIndex > 0) {
      currentIndex = currentIndex - 1;
      pageController.animateToPage(currentIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      notifyListeners();
    }
  }

  onClickNext(BuildContext context) {
    if (currentIndex < 2) {
      currentIndex = currentIndex + 1;
      pageController.animateToPage(currentIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      notifyListeners();
    } else {
      onClickSkip(context);
    }
  }

  onClickSkip(BuildContext context) {
    LoginView().launch(context, isNewTask: true);
  }

  void setCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }
}
