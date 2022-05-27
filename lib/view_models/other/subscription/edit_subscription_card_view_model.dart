import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';
import 'package:zimbo/model/request/charge_card_req.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/time_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class EditSubscriptionCardViewModel extends BaseViewModel {
  DateTime expireDate = DateTime.now();
  String expireDateStr = '';
  String publishKey ='';
  String? token;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();
    await networkService.doGetStripeKey(token!).then((value) => {
      if(value != null){
        publishKey = value,
      }
    });
  }

  onClickSave(BuildContext context, cardNumber, cardHolder, expire, cvv) async {
        final stripe = Stripe(publishKey);
        StripeCard card = StripeCard(number: cardNumber, cvc: cvv, expMonth: expireDate.month, expYear: expireDate.year);

        if(!card.validateNumber()){
          showMessage(StringUtils.txtInvalideCardNumber, null);
          return;
        }else if(!card.validateDate()){
          showMessage(StringUtils.txtInvalideDate, null);
          return;
        }else if(!card.validateCVC()){
          showMessage(StringUtils.txtInvalideCVV, null);
          return;
        }

        var sourceId  = '';
        ChargeCardReq req;
        await stripe.api.createSource(card.toPaymentMethod()).then((value) async => {
          
          sourceId = value['id'],
          req = ChargeCardReq(sourceId: sourceId, planId: '1'),
          await networkService.doChargeCard(token!, req).then((value) => {
            if(value){
              showMessage(StringUtils.txtSubscriptionSuccess, null),
              finishView(context, true),
            }else {
              showMessage(StringUtils.txtSubscriptionFailed, null),
              finishView(context),
            }
          }),
        });
    }

  void onClickDatePicker(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2010, 1, 1),
        maxTime: DateTime(2100, 1, 1),
        theme: const DatePickerTheme(
            headerColor: ColorUtils.appColorWhite,
            backgroundColor: ColorUtils.appColorPrimaryDark,
            itemStyle: TextStyle(color: ColorUtils.appColorTextDark, fontWeight: FontWeight.w400, fontSize: 18),
            doneStyle: TextStyle(color: ColorUtils.appColorAccent, fontSize: 16)),
        onChanged: (date) {
          
        }, 
        onConfirm: (date) {
          expireDate = date;
          expireDateStr = readDateYYYYMMDD(expireDate);

          notifyListeners();
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
}
