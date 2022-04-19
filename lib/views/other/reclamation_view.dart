import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/reclamation_view_model.dart';

class ReclamationView extends StatelessWidget {
  const ReclamationView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReclamationViewModel>.reactive(
      viewModelBuilder: () => ReclamationViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, ReclamationViewModel model, Widget? child) {
    return WillPopScope(
        child: Scaffold(
        backgroundColor: ColorUtils.appColorBlue,
        appBar: AppBar(
          title: textView(StringUtils.txtReclamation,
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
              finishView(context, 2);
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                ],
              ),
            ),
          ],
        )),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}