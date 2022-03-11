
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/point_item_model.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/how_work_view.dart';

class HomeViewModel extends BaseViewModel {

  UserModel? userModel;
  String? token;
  List<PointItemModel> mList = [];

  initialize(BuildContext context) async {
    userModel = await sharedService.getUser();
    token = await sharedService.getToken();

    await networkService.doGetPointHistory(token!).then((value) => {
      if(value != null){
        mList = value,
        notifyListeners(),
      }
    });

  }

  onClickScore(BuildContext context) {
    const HowWorkView().launch(context);
  }

}