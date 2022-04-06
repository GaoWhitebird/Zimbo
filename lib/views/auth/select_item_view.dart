import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/auth/select_item_view_model.dart';
import 'package:zimbo/views/items/item_recyclable_view.dart';

class SelectItemView extends StatelessWidget {
  const SelectItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectItemViewModel>.reactive(
      viewModelBuilder: () => SelectItemViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, SelectItemViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorBlue);
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset : false,
          appBar: AppBar(
            title: Image.asset(ImageUtils.imgIcLogo, width: width * 0.15, fit: BoxFit.scaleDown),
              backgroundColor: ColorUtils.appColorBlue,
              centerTitle: true,
              elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            color: ColorUtils.appColorBlue,
            child: Column(
            children: [
              textView(StringUtils.txtHowManyItems,
                  textColor: ColorUtils.appColorWhite,
                  fontSize: SizeUtils.textSizeNormal,
                  fontWeight: FontWeight.w600,
                  isCentered: true,
                  maxLine: 2),
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
                    textContent: StringUtils.txtNext,
                    textSize: SizeUtils.textSizeMedium,
                    radius: 30,
                    onPressed: () => model.onClickNext(context)),
              ),
            ],
          ),
          )
          
        ),
        onWillPop: () {
          // showDialog(
          //   context: context,
          //   builder: (BuildContext dlgContext) => const ExitDialog(),
          // );
          finishView(context);
          return Future.value(false);
        });
  }

  List<Widget> getChildList(SelectItemViewModel model) {
    return model.mList.map((item){
      return RecyclableItemView(
        model: item,
      );
    }).toList();
  }
}
