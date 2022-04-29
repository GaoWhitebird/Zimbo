import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/subscription/subscription_history_view_model.dart';
import 'package:zimbo/views/items/item_payment_history.dart';

class SubscriptionHistoryView extends StatelessWidget {
  const SubscriptionHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubscriptionHistoryViewModel>.reactive(
      viewModelBuilder: () => SubscriptionHistoryViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, SubscriptionHistoryViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorBlue,
          appBar: AppBar(
            title: textView(StringUtils.txtPaymentHistory,
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
          body: ListView(
            children: getChildList(model),
          ),
        ),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }

  List<Widget> getChildList(SubscriptionHistoryViewModel model) {
    return model.mList.map((item) {
      return PaymentHistoryItem(
        model: item,
      );
    }).toList();
  }
}
