import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/main/home_detail_view_model.dart';
import 'package:zimbo/views/items/item_summary_view.dart';

// ignore: must_be_immutable
class HomeDetailView extends StatelessWidget {
  HomeDetailView({Key? key, required this.type}) : super(key: key);

  String type;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeDetailViewModel>.reactive(
      viewModelBuilder: () => HomeDetailViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context, type),
    );
  }

  buildWidget(BuildContext context, HomeDetailViewModel model, Widget? child) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorUtils.appColorBlue,
      appBar: AppBar(
              title: textView(model.title,
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
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
                height: height * 0.15,
                alignment: Alignment.center,
                child: textView(model.total,
                    textColor: ColorUtils.appColorWhite,
                    fontSize: SizeUtils.textSizeXLarge,
                    fontWeight: FontWeight.w600,
                    isCentered: true,
                    maxLine: 1),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: getChildList(context, model),
                )
              ),
          ],
        )
      )
    );
  }

  List<Widget> getChildList(BuildContext context, HomeDetailViewModel model) {
    return model.mList.map((item) {
      return SummaryItemView(
        model: item,
      );
    }).toList();
  }
}
