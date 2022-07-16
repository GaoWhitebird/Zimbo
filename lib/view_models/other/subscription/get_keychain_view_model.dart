import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

import '../../../model/request/add_postal_address_req.dart';
import '../../../views/main/main_view.dart';

class GetKeychainViewModel extends BaseViewModel {
  var stateItems = <Text>[];
  var stateItemValues = ['NSW', 'QLD', 'SA', 'TAS', 'VIC', 'WA', 'ACT', 'NT'];
  String? token;
  UserModel? userModel;
  initialize(
      BuildContext context,
      TextEditingController controllerFirstName,
      TextEditingController controllerLastName,
      TextEditingController controllerStreet,
      TextEditingController controllerApt,
      TextEditingController controllerCity,
      TextEditingController controllerState,
      TextEditingController controllerZipCode,
      TextEditingController controllerCountry) async {
    token = await sharedService.getToken();
    userModel = await sharedService.getUser();
    stateItems = stateItemValues.map((value) => Text(value)).toList();

    controllerFirstName.text = userModel!.firstName!;
    controllerLastName.text = userModel!.lastName!;
    controllerStreet.text = userModel!.street!;
    controllerApt.text = userModel!.apt!;
    controllerCity.text = userModel!.city!;
    controllerState.text = userModel!.state!;
    controllerZipCode.text = userModel!.zipCode!;
    controllerCountry.text = userModel!.country!;

    notifyListeners();
  }

  onClickSubmit(
      BuildContext context,
      String firstName,
      String lastName,
      String street,
      String apt,
      String city,
      String state,
      String postCode,
      String country) async {
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

    hideKeyboard(context);
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
      if (value) {
        showMessage(StringUtils.txtKeychainIsOnWayGet, null);
        userModel!.firstName = firstName;
        userModel!.lastName = lastName;
        userModel!.street = street;
        userModel!.apt = apt;
        userModel!.city = city;
        userModel!.state = state;
        userModel!.zipCode = postCode;
        userModel!.country = country;
        sharedService.saveUser(userModel);

        MainView().launch(context, isNewTask: true);
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
