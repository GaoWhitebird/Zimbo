import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/model/request/add_recyclable_req.dart';
import 'package:zimbo/model/request/recyclable_item_req.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/main/main_view.dart';

class SelectItemViewModel extends BaseViewModel {
  List<RecyclableItemModel> mList = <RecyclableItemModel>[];
  String? token;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();

    await networkService.doGetRecyclableItemList(token!).then((value) => {
          if (value != null)
            {
              mList = value,
            }
        });

    notifyListeners();
  }

  onClickNext(BuildContext context) {
    List<RecyclableItemReq> list = [];
    for (int i = 0; i < mList.length; i++){
      if(mList[i].isChecked == '1'){
        RecyclableItemReq req = RecyclableItemReq(id: mList[i].id, count: mList[i].count);
        list.add(req);
      }
    }

    networkService.doAddRecyclableItems(token!, AddRecyclableReq(list: jsonEncode(list))).then((value) => {
      if(value != null) {
        const MainView().launch(context, isNewTask: false),
      }
    });
  }
}
