import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/main/sphere_view_model.dart';

class SphereView extends StatelessWidget {
  const SphereView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SphereViewModel>.reactive(
      viewModelBuilder: () => SphereViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, SphereViewModel model, Widget? child) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorUtils.appColorBlue,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(ImageUtils.imgIcIntro2, width: width * 0.3, height: width * 0.3,),
            textView(StringUtils.txtZimboSphere,
              textColor: ColorUtils.appColorWhite,
              fontSize: SizeUtils.textSizeNormal,
              fontWeight: FontWeight.w600,
              isCentered: false),
          ],
        ),
      )
    );
  }
}