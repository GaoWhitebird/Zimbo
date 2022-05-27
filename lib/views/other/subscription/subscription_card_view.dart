import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/subscription/subscription_card_view_model.dart';

class SubscriptionCardView extends StatelessWidget {
  const SubscriptionCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubscriptionCardViewModel>.reactive(
      viewModelBuilder: () => SubscriptionCardViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, SubscriptionCardViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorBlue,
          appBar: AppBar(
            title: textView(StringUtils.txtSubscription,
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
            actions: [
              IconButton(
                splashRadius: 25,
                icon: const Icon(
                  Icons.edit_outlined,
                  color: ColorUtils.appColorTextTitle,
                ),
                onPressed: () {
                  model.onClickEdit(context);
                },
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  height: height * 0.25,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: ColorUtils.appColorGreyCard,
                      boxShadow: [
                        BoxShadow(
                            color: ColorUtils.appColorBlack_10,
                            blurRadius: 10,
                            offset: Offset(0, 0)),
                      ]),
                  child: DottedBorder(
                      color: ColorUtils.appColorTextWhite,
                      strokeWidth: 1,
                      radius: const Radius.circular(10),
                      child: GestureDetector(
                        onTap: () => model.onClickAddCard(context),
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.credit_card_outlined,
                                color: ColorUtils.appColorTextLight,
                              ),
                              textView(StringUtils.txtAddCard,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeUtils.textSizeMedium,
                                  textColor: ColorUtils.appColorTextTitle),
                              textView(StringUtils.txtSubscriptionCancel,
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeUtils.textSizeSmall,
                                  textColor: ColorUtils.appColorRedDark).visible(!model.isSubscription && model.hasHistory)
                            ],
                          ),
                        ),
                      ))),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RoundButton(
                      isStroked: false,
                      textContent: StringUtils.txtPaymentHistory,
                      onPressed: () => model.onClickHistory(context),
                      backgroundColor: ColorUtils.appColorAccent,
                      textColor: ColorUtils.appColorWhite,
                      textSize: SizeUtils.textSizeMedium,
                      radius: 30,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        textView(
                          StringUtils.txtNextPayment,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeSmall,
                          fontWeight: FontWeight.w300,
                          isCentered: true,
                        ),
                        textView(
                          model.nextDate,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeSmall,
                          fontWeight: FontWeight.w600,
                          isCentered: true,
                        ),
                      ],
                    )),
                  ],
                ),
              ).visible(model.hasHistory),
              Container(
                height: 1,
                color: ColorUtils.appColorAccent_5,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      textView(StringUtils.txtWhatInIncluded,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeLargeMedium,
                          fontWeight: FontWeight.w600,
                          isCentered: false,
                          maxLine: 2),
                      Container(height: 10,),
                      textView(StringUtils.txtWhatInIncludedDescription,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeSmall,
                          isCentered: false,
                          maxLine: 8),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.all(10),
                child: RoundButton(
                      isStroked: true,
                      textContent: StringUtils.txtCancelPayment,
                      onPressed: () => model.onClickCancelPayment(context),
                      backgroundColor: ColorUtils.appColorWhite,
                      textColor: ColorUtils.appColorBlue,
                      textSize: SizeUtils.textSizeMedium,
                      radius: 30,
                ),
              ).visible(model.isSubscription),
            ],
          ),
        ),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
