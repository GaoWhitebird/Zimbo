import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/main/home_view_model.dart';
import 'package:zimbo/views/items/item_home_score.dart';
import 'package:zimbo/views/items/item_point_history.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin{
  
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }
  @override
  void didUpdateWidget(covariant HomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, HomeViewModel model, Widget? child) {
    return Scaffold(
        backgroundColor: ColorUtils.appColorBlue,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: HomeScoreItem(model: model.userModel),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: GestureDetector(
                child: textViewUnderline(
                  StringUtils.txtHowCanIImprove,
                  textColor: ColorUtils.appColorWhite,
                  fontSize: SizeUtils.textSizeSMedium,
                  fontWeight: FontWeight.w500,
                  isCentered: false,
                ),
                onTap: () => model.onClickScore(context),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              child: textView(StringUtils.txtReuseHistory,
                  textColor: ColorUtils.appColorWhite,
                  fontSize: SizeUtils.textSizeNormal,
                  fontWeight: FontWeight.w600,
                  isCentered: false),
            ),
            SizedBox(
              child: ListView(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: getChildList(model),
              ),
            ),
          ]),
        ));
  }

  List<Widget> getChildList(HomeViewModel model) {
    return model.mList.map((item) {
      return PointHistoryItem(
        model: item,
      );
    }).toList();
  }

  @override
  bool get wantKeepAlive => false;
}
