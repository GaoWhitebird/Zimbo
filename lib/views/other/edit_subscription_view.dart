import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/edit_subscription_view_model.dart';

class EditSubscriptionView extends StatelessWidget {
  EditSubscriptionView({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerCardNumber =
      TextEditingController();
  final TextEditingController textEditingControllerCardHolder =
      TextEditingController();
  final TextEditingController textEditingControllerExpire =
      TextEditingController();
  final TextEditingController textEditingControllerCVV =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditSubscriptionViewModel>.reactive(
      viewModelBuilder: () => EditSubscriptionViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, EditSubscriptionViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    textEditingControllerExpire.text = model.expireDateStr;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorBlue,
          appBar: AppBar(
            title: textView(StringUtils.txtEditPaymentDetails,
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
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                      height: height * 0.25,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: ColorUtils.appColorAccent,
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
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.credit_card_outlined,
                                color: ColorUtils.appColorWhite,
                              ),
                              textView(StringUtils.txtAddCard,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeUtils.textSizeMedium,
                                  textColor: ColorUtils.appColorWhite)
                            ],
                          ),
                        ),
                      )),
                  Container(
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: ColorUtils.appColorWhite,
                        boxShadow: [
                          BoxShadow(
                              color: ColorUtils.appColorBlack_10,
                              blurRadius: 10,
                              offset: Offset(0, 0)),
                        ]),
                    padding: const EdgeInsets.all(10),
                    width: width,
                    height: height * 0.7,
                    child: Column(
                      children: [
                        EditTextField(
                          hintText: StringUtils.txtCardNumber,
                          isPassword: false,
                          isSecure: false,
                          mController: textEditingControllerCardNumber,
                          borderColor: ColorUtils.appColorBlack_10,
                          textInputType: TextInputType.number,
                          inputFormatters: [CreditCardNumberInputFormatter()],
                        ),
                        EditTextField(
                          hintText: StringUtils.txtCardHolder,
                          isPassword: false,
                          isSecure: false,
                          mController: textEditingControllerCardHolder,
                          borderColor: ColorUtils.appColorBlack_10,
                        ),
                        EditTextField(
                            hintText: StringUtils.txtExpireDate,
                            isPassword: false,
                            isSecure: false,
                            mController: textEditingControllerExpire,
                            borderColor: ColorUtils.appColorBlack_10,
                            autoFocus: false,
                            textInputType: TextInputType.datetime,
                            enableInteractiveSelection: false,
                            onTap: () { FocusScope.of(context).requestFocus(new FocusNode()); model.onClickDatePicker(context);},
                           ),
                        EditTextField(
                          hintText: StringUtils.txtCVV,
                          isPassword: false,
                          isSecure: false,
                          mController: textEditingControllerCVV,
                          borderColor: ColorUtils.appColorBlack_10,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: RoundButton(
                                      isStroked: false,
                                      textContent: StringUtils.txtSave,
                                      textSize: SizeUtils.textSizeMedium,
                                      radius: 30,
                                      onPressed: () => model.onClickSave(
                                          context,
                                          textEditingControllerCardNumber.text,
                                          textEditingControllerCardHolder.text,
                                          textEditingControllerExpire.text,
                                          textEditingControllerCVV.text)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
