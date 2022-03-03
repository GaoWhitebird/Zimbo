import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/model/request/add_recyclable_req.dart';
import 'package:zimbo/model/request/recyclable_item_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class AddItemViewModel extends BaseViewModel {
  List<RecyclableItemModel> mList = [];
  String? token;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();

    await networkService.doGetAvailableRecyclableItemList(token!).then((value) => {
          if (value != null)
            {
              mList = value,
              notifyListeners(),
            }
        });

  }

  onClickAddItems(BuildContext context) {
    List<RecyclableItemReq> list = [];
    for (int i = 0; i < mList.length; i++){
      if(mList[i].isChecked == '1'){
        RecyclableItemReq req = RecyclableItemReq(id: mList[i].id, image: mList[i].count);
        list.add(req);
      }
    }

    networkService.doAddRecyclableItems(token!, AddRecyclableReq(list: jsonEncode(list))).then((value) => {
      if(value != null) {
        showMessage(StringUtils.txtRecyclableItemsAdded, null),
        finishView(context, true),
      }else {
        finishView(context, true),
      }
    });
  }

}