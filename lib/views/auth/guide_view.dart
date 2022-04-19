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
    setStatusBarColor(ColorUtils.appColorBlue);
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: textView(StringUtils.txtSimplifyingSustainability,
              textColor: ColorUtils.appColorWhite,
              fontSize: SizeUtils.textSizeNormal,
              fontWeight: FontWeight.w500,
              isCentered: true),
            backgroundColor: ColorUtils.appColorBlue,
            centerTitle: true,
            elevation: 0,
            leading: BackButton(
              color: ColorUtils.appColorWhite,
              onPressed: () {
                finishView(context);
              },
            ),
          ),
          body: Container(
            color: ColorUtils.appColorBlue,
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
