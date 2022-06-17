import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

import '../../../model/request/add_postal_address_req.dart';

class GetKeychainViewModel extends BaseViewModel {
  var stateItems = <Text>[];
  var stateItemValues = ['NSW', 'QLD', 'SA', 'TAS', 'VIC', 'WA', 'ACT', 'NT'];
  String? token;
  UserModel? userModel;
  initialize(
      BuildContext context,
      TextEditingController controllerAddress1,
      TextEditingController controllerAddress2,
      TextEditingController controllerSuburb,
      TextEditingController controllerState,
      TextEditingController controllerPostCode) async {
    token = await sharedService.getToken();
    userModel = await sharedService.getUser();
    stateItems = stateItemValues.map((value) => Text(value)).toList();

    controllerAddress1.text = userModel!.address1!;
    controllerAddress2.text = userModel!.address2!;
    controllerSuburb.text = userModel!.suburb!;
    controllerState.text = userModel!.state!;
    controllerPostCode.text = userModel!.postalCode!;

    notifyListeners();
  }

  onClickSubmit(BuildContext context, String address1, String address2,
      String suburb, String state, String postCode) async {
    if (address1.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterAddress, null);
      return;
    }
    if (suburb.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterSuburb, null);
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

    hideKeyboard(context);
    AddPostalAddressReq req = AddPostalAddressReq(
        address1: address1,
        address2: address2,
        suburb: suburb,
        state: state,
        postcode: postCode);
    networkService.doAddPostalAddress(token!, req).then((value) {
      if (value) {
        showMessage(StringUtils.txtKeychainIsOnWayGet, null);

        userModel!.address1 = address1;
        userModel!.address2 = address2;
        userModel!.suburb = suburb;
        userModel!.state = state;
        userModel!.postalCode = postCode;
        sharedService.saveUser(userModel);

        finishView(context);
      } else {
        showMessage(StringUtils.txtSomethingWentWrong, null);
      }
    });
  }

  showBottomPicker(
      BuildContext context, TextEditingController textEditingControllerState) {
    BottomPicker(
      items: stateItems,
      title: StringUtils.txtState,
      titleStyle: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: SizeUtils.textSizeNormal),
      pickerTextStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: SizeUtils.textSizeNormal,
          color: ColorUtils.appColorTextDark),
      dismissable: true,
      displaySubmitButton: true,
      displayButtonIcon: false,
      buttonText: StringUtils.txtSelect,
      buttonTextStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: SizeUtils.textSizeMedium,
          color: ColorUtils.appColorWhite),
      buttonSingleColor: ColorUtils.appColorBlue,
      onSubmit: (selectedValue) {
        textEditingControllerState.text = stateItemValues[selectedValue];
        notifyListeners();
      },
    ).show(context);
  }
}
