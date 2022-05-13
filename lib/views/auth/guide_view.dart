import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/auth/guide_view_model.dart';
import 'package:zimbo/views/items/item_guide_view.dart';

class GuideView extends StatelessWidget {
  const GuideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GuideViewModel>.reactive(
      viewModelBuilder: () => GuideViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, GuideViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorBlue,
          appBar: AppBar(
              title: textView(StringUtils.txtSimplifyingSustainability,
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
                onPressed: () {
                  finishView(context);
                },
              ),
            ),
          body: SizedBox(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: model.mList.map((item) {
                return ItemGuideView(
                  model: item,
                );
              }).toList(),
            ),
          ),
        ),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
