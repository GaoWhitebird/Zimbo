import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/main/home_view_model.dart';
import 'package:zimbo/views/items/item_home_score.dart';
import 'package:zimbo/views/items/item_point_history.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, HomeViewModel model, Widget? child) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          child: HomeScoreItem(model: model.userModel),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          child: textView(StringUtils.txtPointHistory,
              textColor: ColorUtils.appColorBlack,
              fontSize: SizeUtils.textSizeNormal,
              fontWeight: FontWeight.w600,
              isCentered: false),
        ),
        Expanded(
          child: ListView(
            children: getChildList(model),
          ),
        ),
      ]),
    );
  }

  List<Widget> getChildList(HomeViewModel model) {
    return model.mList.map((item) {
      return PointHistoryItem(
        model: item,
      );
    }).toList();
  }
}
