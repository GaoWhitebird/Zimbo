import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/add_score_view_model.dart';
import 'package:zimbo/views/items/item_score_recyclable_view.dart';

class AddScoreView extends StatelessWidget {
  const AddScoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddScoreViewModel>.reactive(
      viewModelBuilder: () => AddScoreViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, AddScoreViewModel model, Widget? child) {
    return Scaffold(
        backgroundColor: ColorUtils.appColorBlue,
        appBar: AppBar(
          title: textView(StringUtils.txtAddScore,
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
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: textView(StringUtils.txtWhatPantryItemsAreYouUsing,
                        textColor: ColorUtils.appColorWhite,
                        fontSize: SizeUtils.textSizeMedium,
                        fontWeight: FontWeight.w600,
                        isCentered: true,
                        maxLine: 3),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: getChildList(context, model),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: RoundButton(
                        isStroked: false,
                        textContent: StringUtils.txtSubmit,
                        textSize: SizeUtils.textSizeMedium,
                        radius: 30,
                        onPressed: () => model.onClickSubmit(context)),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  List<Widget> getChildList(BuildContext context, AddScoreViewModel model) {
    return model.mList.map((item) {
      return ScoreRecyclableItemView(
        model: item,
        onDelete: () {},
        onAddRemove: () {
          model.onAddRemoveClicked(context, item);
        },
      );
    }).toList();
  }
}
