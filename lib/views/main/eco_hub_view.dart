import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/view_models/main/echo_hub_view_model.dart';
import 'package:zimbo/views/items/item_eco_hub_view.dart';

class EcoHubView extends StatelessWidget {
  const EcoHubView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EcoHubViewModel>.reactive(
      viewModelBuilder: () => EcoHubViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

buildWidget(BuildContext context, EcoHubViewModel model, Widget? child) {
    return Scaffold(
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: ColorUtils.appColorBlack,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: model.mList.map((item){
            return EcoHubItemView(
              model: item,
            );
          }).toList(),
        ),
      ),
    );
  }
}