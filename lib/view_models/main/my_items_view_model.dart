import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/model/request/add_recyclable_req.dart';
import 'package:zimbo/model/request/delete_recyclable_req.dart';
import 'package:zimbo/model/request/recyclable_item_req.dart';
import 'package:zimbo/model/request/update_recyclable_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/auth/pantry_item_photo_view.dart';
import 'package:zimbo/views/other/add_item_view.dart';

class MyItemsViewModel extends BaseViewModel {
  List<RecyclableItemModel> mList = [];
  List<RecyclableItemModel> mAdditionalList = [];
  String? token;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();
    await networkService.doGetUserRecyclableList(token!).then((value) => {
          if (value != null)
            {
              mList = value[0],
              mAdditionalList = value[1],
              notifyListeners(),
            }
        });
  }

  void onDeleteClicked(BuildContext context, RecyclableItemModel item) async {
    DeleteRecyclableReq req = DeleteRecyclableReq(recyclableId: item.id);
    await networkService.doDeleteRecyclableItem(token!, req).then((value) => {
          if (value != null)
            {
              sharedService.saveUser(value),
              showMessage(StringUtils.txtRecyclableItemsRemoved, null),
              mAdditionalList.add(item),
              mList.removeWhere((element) => element.id == item.id),
              notifyListeners(),
            }else {
              showMessage(StringUtils.txtRecyclableItemsRemovedFail, null),
            }
        });
  }

  
  void onAddRemoveClicked(BuildContext context, RecyclableItemModel item) async {
    UpdateRecyclableReq req = UpdateRecyclableReq(recyclableId: item.id, count: item.count);
    await networkService.doUpdateRecyclableCount(token!, req).then((value) => {
      if(value != null){
        sharedService.saveUser(value),
      }
    });
  }

  onClickAdd(BuildContext context) async {
    final result = await const AddItemView().launch(context, isNewTask: false);
    if (result) {
      initialize(context);
    }
  }


  onClickAddItem(BuildContext context, RecyclableItemModel item) async {
    List list = [];
    RecyclableItemReq req = RecyclableItemReq(id: item.id,);
    list.add(req.toJson());

    networkService.doAddRecyclableItems(token!, AddRecyclableReq(list: list)).then((value) => {
      if(value != null) {
        showMessage(StringUtils.txtRecyclableItemsAdded, null),
        mList.add(item),
        mAdditionalList.removeWhere((element) => element.id == item.id),

        PantryItemPhotoView([item]).launch(context),
      }else {
        showMessage(StringUtils.txtRecyclableItemsAddedFail, null),
      },

      notifyListeners(),
    });
  }
}
