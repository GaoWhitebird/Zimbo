
import 'package:flutter/material.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class GuideViewModel extends BaseViewModel {

  initialize(BuildContext context) async {

  }

  onClickGotIt(BuildContext context) {
    //const MainView().launch(context, isNewTask: true);
    finishView(context);
  }

}