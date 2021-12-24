import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:nb_utils/src/extensions/widget_extensions.dart';
import 'package:zimbo/model/recyclable_item_model.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/main/main_view.dart';

class SelectItemViewModel extends BaseViewModel {
  List<RecyclableItemModel> mList = <RecyclableItemModel>[];

  initialize(BuildContext context) async {
    mList.add(RecyclableItemModel(
        id: 0,
        image:
            'https://cdn.shopify.com/s/files/1/0084/7770/4252/products/EMB003_Electric_mug__LARGE_black_Web_2000x.jpg?v=1597239612',
        name: 'ELECTRIC COFFEE MUG',
        count: 0,
        isChecked: false));
      mList.add(RecyclableItemModel(
        id: 0,
        image:
            'https://www.thespruceeats.com/thmb/FeLgdcaqlcddHD9e2CXeIIhtmYA=/fit-in/280x230/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/NespressoVertuoandMilkFrother-fcbedcaa92f04fd2a8a5462999e89804.jpg',
        name: 'Coffee Pod',
        count: 0,
        isChecked: false));
      mList.add(RecyclableItemModel(
        id: 0,
        image:
            'https://i.insider.com/60cb7a5823393a00188e3cfb?width=1000&format=jpeg&auto=webp',
        name: 'Bottle',
        count: 0,
        isChecked: false));
      mList.add(RecyclableItemModel(
        id: 0,
        image:
            'https://assets.hermes.com/is/image/hermesproduct/tote-bag--1462298%2092-front-1-300-0-850-850_b.jpg',
        name: 'Bag',
        count: 0,
        isChecked: false));

      notifyListeners();
  }

  onClickNext(BuildContext context) {
    const MainView().launch(context, isNewTask: false);
  }
}
