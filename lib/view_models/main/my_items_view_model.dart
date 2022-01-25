import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/model/request/delete_recyclable_req.dart';
import 'package:zimbo/model/request/update_recyclable_req.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/add_item_view.dart';

class MyItemsViewModel extends BaseViewModel {
  List<RecyclableItemModel> mList = [];
  String? token;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();
    await networkService.doGetUserRecyclableList(token!).then((value) => {
          if (value != null)
            {
              mList = value,
              notifyListeners(),
            }
        });
  }

  void onDeleteClicked(BuildContext context, RecyclableItemModel item) async {
    DeleteRecyclableReq req = DeleteRecyclableReq(recyclableId: item.id);
    await networkService.doDeleteRecyclableItem(token!, req).then((value) => {
          if (value)
            {
              mList.remove(item),
              notifyListeners(),
            }
        });
  }

  
  void onAddRemoveClicked(BuildContext context, RecyclableItemModel item) async {
    UpdateRecyclableReq req = UpdateRecyclableReq(recyclableId: item.id, count: item.count);
    await networkService.doUpdateRecyclableCount(token!, req).then((value) => {
      if(value){
        
      }
    });
  }

  onClickAdd(BuildContext context) async {
    final result = await const AddItemView().launch(context, isNewTask: false);
    if (result) {
      initialize(context);
    }
  }

}
