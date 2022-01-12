import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/add_item_view_model.dart';
import 'package:zimbo/views/items/item_recyclable_view.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddItemViewModel>.reactive(
      viewModelBuilder: () => AddItemViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, AddItemViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: textView(StringUtils.txtAddItem,
                textColor: ColorUtils.appColorTextTitle,
                fontSize: SizeUtils.textSizeNormal,
                fontWeight: FontWeight.w500,
                isCentered: true),
            backgroundColor: ColorUtils.appColorWhite,
            centerTitle: true,
            elevation: 0,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            leading: BackButton(
              color: ColorUtils.appColorBlack,
              onPressed: () {finishView(context, false);},
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: ListView(
                    children: getChildList(model),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: RoundButton(
                    isStroked: false,
                    textContent: StringUtils.txtAddItems,
                    textSize: SizeUtils.textSizeMedium,
                    radius: 30,
                    onPressed: () => model.onClickAddItems(context)),
              ),
            ],
          ),
        ),
        onWillPop: () {
          finishView(context, false);
          return Future.value(false);
        });
  }

  List<Widget> getChildList(AddItemViewModel model) {
    return model.mList.map((item){
      return RecyclableItemView(
        model: item,
      );
    }).toList();
  }
}
