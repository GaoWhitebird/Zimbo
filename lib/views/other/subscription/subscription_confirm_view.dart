import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/subscription/subscription_confirm_view_model.dart';
import 'package:zimbo/views/main/main_view.dart';

import '../../../utils/api_utils.dart';
import '../../../utils/maps_places_autocomplete/maps_places_autocomplete.dart';
import '../../../utils/maps_places_autocomplete/model/place.dart';
import '../../../utils/maps_places_autocomplete/model/suggestion.dart';

class SubscriptionConfirmView extends StatelessWidget {
  SubscriptionConfirmView({Key? key}) : super(key: key);
  final TextEditingController textEditingControllerFirstName =
      TextEditingController();
    final TextEditingController textEditingControllerLastName =
      TextEditingController();
  final TextEditingController textEditingControllerStreet =
      TextEditingController();
  final TextEditingController textEditingControllerApt =
      TextEditingController();
  final TextEditingController textEditingControllerCity =
      TextEditingController();
  final TextEditingController textEditingControllerStateProvince =
      TextEditingController();
  final TextEditingController textEditingControllerZipCode =
      TextEditingController();
  final TextEditingController textEditingControllerCountry =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubscriptionConfirmViewModel>.reactive(
      viewModelBuilder: () => SubscriptionConfirmViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, SubscriptionConfirmViewModel model, Widget? child) {
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
                  MainView().launch(context, isNewTask: true);
                },
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.05,
                  ),
                  textView(StringUtils.txtSubscriptionConfirmed,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeLarge,
                      fontWeight: FontWeight.w600,
                      isCentered: true,
                      maxLine: 2),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      textView(StringUtils.txtTimeToReceiveKey,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeMedium,
                          fontWeight: FontWeight.w400,
                          isCentered: true,
                          maxLine: 2),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      textView(StringUtils.txtPleaseEnterPostalAddress,
                          textColor: ColorUtils.appColorWhite_50,
                          fontSize: SizeUtils.textSizeSmall,
                          fontWeight: FontWeight.w400,
                          isCentered: true,
                          maxLine: 2),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      EditTextField(
                        hintText: StringUtils.txtFistName,
                        hintColor: ColorUtils.appColorWhite,
                        isPassword: false,
                        isSecure: false,
                        mController: textEditingControllerFirstName,
                        borderColor: ColorUtils.appColorWhite,
                        textColor: ColorUtils.appColorWhite,
                      ),
                      EditTextField(
                        hintText: StringUtils.txtLastName,
                        hintColor: ColorUtils.appColorWhite,
                        isPassword: false,
                        isSecure: false,
                        mController: textEditingControllerLastName,
                        borderColor: ColorUtils.appColorWhite,
                        textColor: ColorUtils.appColorWhite,
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.all(10),
                        child: MapsPlacesAutocomplete(
                            showGoogleTradeMark: false,
                            containerDecoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: ColorUtils.appColorGreyLight),
                                  color: ColorUtils.appColorWhite,
                                  boxShadow: const [
                                     BoxShadow(
                                        color: ColorUtils.appColorBlack_10,
                                        blurRadius: 10,
                                        offset: Offset(0, 0)),
                                  ]),
                            mapsApiKey: ApiUtils.urlMapApiKey,
                            onSuggestionClick: (Place place){
                              String? _street = place.street;
                              String? _city = place.city;
                              String? _state = place.state;
                              String? _zipCode = place.zipCode;
                              String? _country = place.country;
                              
                              textEditingControllerStreet.text = _street ?? '';
                              textEditingControllerCity.text = _city ?? '';
                              textEditingControllerStateProvince.text = _state ?? '';
                              textEditingControllerZipCode.text = _zipCode ?? '';
                              textEditingControllerCountry.text = _country ?? '';
                            },
                            buildItem: (Suggestion suggestion, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: ColorUtils.appColorGreyLight),
                                  ),
                                margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.centerLeft,
                                child: textView(suggestion.description, fontSize: SizeUtils.textSizeSmall)
                              );
                            },
                            inputDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(25, 8, 4, 8),
                              labelText: StringUtils.txtStreet,
                              hintStyle: const TextStyle(
                                  color: ColorUtils.appColorWhite),
                              labelStyle: const TextStyle(
                                  color: ColorUtils.appColorWhite,
                                  fontSize: SizeUtils.textSizeSmall),
                              filled: true,
                              fillColor:ColorUtils.appColorTransparent,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide( color: ColorUtils.appColorWhite, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(color: ColorUtils.appColorWhite, width: 1),
                              ),
                              focusColor: ColorUtils.appColorWhite,
                              hoverColor: ColorUtils.appColorWhite,
                              errorText: null),
                            clearButton: const Icon(Icons.close, color: ColorUtils.appColorWhite,),
                            textEditingController: textEditingControllerStreet,
                          ),
                        ),
                      
                      EditTextField(
                        hintText: StringUtils.txtApt,
                        hintColor: ColorUtils.appColorWhite,
                        isPassword: false,
                        isSecure: false,
                        mController: textEditingControllerApt,
                        borderColor: ColorUtils.appColorWhite,
                        textColor: ColorUtils.appColorWhite,
                      ),
                      EditTextField(
                        hintText: StringUtils.txtCity,
                        hintColor: ColorUtils.appColorWhite,
                        isPassword: false,
                        isSecure: false,
                        mController: textEditingControllerCity,
                        borderColor: ColorUtils.appColorWhite,
                        textColor: ColorUtils.appColorWhite,
                      ),
                      EditTextField(
                        hintText: StringUtils.txtStateProvince,
                        hintColor: ColorUtils.appColorWhite,
                        isPassword: false,
                        isSecure: false,
                        mController: textEditingControllerStateProvince,
                        borderColor: ColorUtils.appColorWhite,
                        textColor: ColorUtils.appColorWhite,
                      ),
                      EditTextField(
                        hintText: StringUtils.txtZipCode,
                        hintColor: ColorUtils.appColorWhite,
                        isPassword: false,
                        isSecure: false,
                        mController: textEditingControllerZipCode,
                        borderColor: ColorUtils.appColorWhite,
                        textColor: ColorUtils.appColorWhite,
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      EditTextField(
                        hintText: StringUtils.txtCountry,
                        hintColor: ColorUtils.appColorWhite,
                        isPassword: false,
                        isSecure: false,
                        mController: textEditingControllerCountry,
                        borderColor: ColorUtils.appColorWhite,
                        textColor: ColorUtils.appColorWhite,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: RoundButton(
                            isStroked: false,
                            textContent: StringUtils.txtSubmit,
                            textSize: SizeUtils.textSizeMedium,
                            radius: 30,
                            onPressed: () => model.onClickSubmit(
                                  context,
                                  textEditingControllerFirstName.text,
                                  textEditingControllerLastName.text,
                                  textEditingControllerStreet.text,
                                  textEditingControllerApt.text,
                                  textEditingControllerCity.text,
                                  textEditingControllerStateProvince.text,
                                  textEditingControllerZipCode.text,
                                  textEditingControllerCountry.text,
                                )),
                      )
                    ],
                  )
                ],
              ),
            )),
        onWillPop: () {
          MainView().launch(context, isNewTask: true);
          return Future.value(false);
        });
  }
}
