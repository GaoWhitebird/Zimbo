import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/main/my_items_view_model.dart';
import 'package:zimbo/views/items/item_used_recyclable_view.dart';

class MyItemsView extends StatelessWidget {
  const MyItemsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyItemsViewModel>.reactive(
      viewModelBuilder: () => MyItemsViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, MyItemsViewModel model, Widget? child) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: getChildList(context, model),
          ),
        ),
        Positioned(
            right: 20,
            bottom: 20,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: ColorUtils.appColorAccent,
              child: IconButton(
                iconSize: 25,
                onPressed: () => model.onClickAdd(context),
                icon: const Icon(
                  Icons.add,
                  color: ColorUtils.appColorWhite,
                ),
              ),
            )),
      ],
    ));
  }

  List<Widget> getChildList(BuildContext context, MyItemsViewModel model) {
    return model.mList.map((item) {
      return UsedRecyclableItemView(
          model: item,
          onDelete: () => showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                    title: StringUtils.txtWarning,
                    description: StringUtils.txtDoYouWantToDelete,
                    okButtonStr: StringUtils.txtDelete,
                    cancelButtonStr: StringUtils.txtCancel,
                    okClicked: () {
                      model.onDeleteClicked(context, item);
                    }),
              ), 
          onAddRemove: () {   
            model.onAddRemoveClicked(context, item);
          },
      );
    }).toList();
  }
}
