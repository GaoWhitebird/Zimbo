
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

import '../../../model/request/add_postal_address_req.dart';
import '../../../views/other/subscription/keychain_confirm_view.dart';

class SubscriptionConfirmViewModel extends BaseViewModel {
  var stateItems = <Text>[];
  var stateItemValues = ['NSW', 'QLD', 'SA', 'TAS', 'VIC', 'WA', 'ACT', 'NT' ];
  String? token;
  initialize(BuildContext context) async {
    token = await sharedService.getToken();
    stateItems = stateItemValues.map((value) => Text(value)).toList();
  }

  onClickSubmit(BuildContext context, String firstName, String lastName, String street, String apt,
      String city, String state, String postCode, String country) async {
    if (firstName.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterName, null);
      return;
    }
    if (lastName.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterName, null);
      return;
    }
    if (street.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterStreet, null);
      return;
    }
    if (city.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterCity, null);
      return;
    }
    if (state.isEmpty) {
      showMessage(StringUtils.txtPleaseSelectState, null);
      return;
    }
    if (postCode.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterPostcode, null);
      return;
    }
    if (country.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterCountry, null);
      return;
    }
    
    AddPostalAddressReq req = AddPostalAddressReq(
        firstName: firstName,
        lastName: lastName,
        street: street,
        apt: apt,
        city: city,
        state: state,
        zipcode: postCode,
        country: country);
    networkService.doAddPostalAddress(token!, req).then((value) {
      if(value) {
        
        const KeychainConfirmView().launch(context, isNewTask: true);
      }else{
        showMessage(StringUtils.txtSomethingWentWrong, null);
      }
    });

  }

  showBottomPicker(BuildContext context, TextEditingController textEditingControllerState){
    BottomPicker(
      items: stateItems,
      title:  StringUtils.txtState,
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize:  SizeUtils.textSizeNormal),
      pickerTextStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize:  SizeUtils.textSizeNormal, color: ColorUtils.appColorTextDark),
      dismissable: true,
      displaySubmitButton: true,
      displayButtonIcon: false,
      buttonText: StringUtils.txtSelect,
      buttonTextStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize:  SizeUtils.textSizeMedium, color: ColorUtils.appColorWhite),
      buttonSingleColor: ColorUtils.appColorBlue,
      onSubmit: (selectedValue){
        textEditingControllerState.text = stateItemValues[selectedValue];
        notifyListeners();
      },
    ).show(context);
  }

}