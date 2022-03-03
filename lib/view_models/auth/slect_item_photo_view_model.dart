import 'package:flutter/material.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class SelectItemPhotoViewModel extends BaseViewModel {
  List<RecyclableItemModel> mList = [];

  initialize(BuildContext context, List<RecyclableItemModel> list) async {
    mList.clear();
    mList.addAll(list);

  }

  void onClickPhoto(BuildContext context, RecyclableItemModel item) async{

  }


  onClickNext(BuildContext context) {}

}