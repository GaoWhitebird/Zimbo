import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/main/main_view.dart';

class SelectShoppingDayViewModel extends BaseViewModel {
  
  initialize(BuildContext context) async {

  }

  onClickApply(BuildContext context) async {

  }

  onClickSkip(BuildContext context) {
    const MainView().launch(context, isNewTask: true);
  }

}