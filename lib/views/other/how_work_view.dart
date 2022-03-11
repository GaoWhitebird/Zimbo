import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/how_work_view_model.dart';
import 'package:zimbo/views/items/item_about_us_view.dart';

class HowWorkView extends StatelessWidget {
  const HowWorkView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HowWorkViewModel>.reactive(
      viewModelBuilder: () => HowWorkViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, HowWorkViewModel model, Widget? child) {
    return Scaffold(
      backgroundColor: ColorUtils.appColorBlue,
      appBar: AppBar(
            title: textView(StringUtils.txtHowCanIImprove,
                textColor: ColorUtils.appColorTextTitle,
                fontSize: SizeUtils.textSizeMedium,
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
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: ColorUtils.appColorBlack,
          useInkWell: true,
        ),
        child: Container(
          color: ColorUtils.appColorBlue,
          child: ListView(
          physics: const BouncingScrollPhysics(),
          children: model.mList.map((item){
            return AboutUSItemView(
              model: item,
            );
          }).toList(),
        ),
        )
        
      ),
    );
  }
}