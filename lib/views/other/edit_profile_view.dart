import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/edit_profile_view_model.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView({ Key? key }) : super(key: key);

  final TextEditingController textEditingControllerName =
      TextEditingController();
  final TextEditingController textEditingControllerPhone =
      TextEditingController();
  final TextEditingController textEditingControllerEmail =
      TextEditingController();
  final TextEditingController textEditingControllerCountry =
      TextEditingController();
  final TextEditingController textEditingControllerAddress =
      TextEditingController();

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      viewModelBuilder: () => EditProfileViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) {
        model.initialize(context, widget.textEditingControllerName, 
        widget.textEditingControllerPhone, widget.textEditingControllerEmail, 
        widget.textEditingControllerCountry, widget.textEditingControllerAddress);
      } ,
    );
  }

  buildWidget(BuildContext context, EditProfileViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorBlue,
            appBar: AppBar(
              title: textView(StringUtils.txtEditProfile,
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
                onPressed: () => {
                  finishView(context),
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                      height: height * 0.2,
                      width: height * 0.2,
                      margin: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorUtils.appColorWhite,
                          boxShadow: [
                            BoxShadow(
                                color: ColorUtils.appColorBlack_10,
                                blurRadius: 10,
                                offset: Offset(0, 0)),
                          ]),
                      child: Stack(children: <Widget>[
                        model.imagePath.isNotEmpty
                            ? Container(
                                alignment: Alignment.center,
                                child: ClipOval(
                                    child: SizedBox.fromSize(
                                  child: Image.file(
                                    new File(model.imagePath),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                  size: Size.fromRadius(height * 0.1),
                                )),
                              )
                            : model.userImage.isNotEmpty ? 
                            Container(
                                alignment: Alignment.center,
                                child: ClipOval(
                                    child: SizedBox.fromSize(
                                  child: Image.network(
                                    model.userImage,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                  size: Size.fromRadius(height * 0.1),
                                )),
                              )
                              :Container(color: ColorUtils.appColorTransparent,),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.camera_alt_outlined,
                                color: ColorUtils.appColorTextLight,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: DottedBorder(
                              color: ColorUtils.appColorTextWhite,
                              strokeWidth: 1,
                              borderType: BorderType.Circle,
                              radius: const Radius.circular(10),
                              child: GestureDetector(
                                onTap: () => model.onClickAddPhoto(context),
                              )),
                        ),
                      ])),
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
                            hintText: StringUtils.txtUserName,
                            isPassword: false,
                            isSecure: false,
                            mController: widget.textEditingControllerName,
                            borderColor: ColorUtils.appColorBlack_10,
                          ),
                          EditTextField(
                            hintText: StringUtils.txtMobilePhone,
                            isPassword: false,
                            isSecure: false,
                            mController: widget.textEditingControllerPhone,
                            borderColor: ColorUtils.appColorBlack_10,
                            textInputType: TextInputType.phone,
                            inputFormatters: [PhoneInputFormatter()],
                          ),
                          EditTextField(
                            hintText: StringUtils.txtEmail,
                            isPassword: false,
                            isSecure: false,
                            mController: widget.textEditingControllerEmail,
                            borderColor: ColorUtils.appColorBlack_10,
                            enableInteractiveSelection: false,
                            onTap: () { FocusScope.of(context).requestFocus(new FocusNode()); },
                          ),
                          EditTextField(
                            hintText: StringUtils.txtCountryCity,
                            isPassword: false,
                            isSecure: false,
                            mController: widget.textEditingControllerCountry,
                            borderColor: ColorUtils.appColorBlack_10,
                          ),
                          EditTextField(
                            hintText: StringUtils.txtAddress,
                            isPassword: false,
                            isSecure: false,
                            mController: widget.textEditingControllerAddress,
                            borderColor: ColorUtils.appColorBlack_10,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: width,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: RoundButton(
                                        isStroked: false,
                                        textContent: StringUtils.txtSave,
                                        textSize: SizeUtils.textSizeMedium,
                                        radius: 30,
                                        onPressed: () => model.onClickSave(
                                            context,
                                            widget.textEditingControllerName.text,
                                            widget.textEditingControllerPhone.text,
                                            widget.textEditingControllerEmail.text,
                                            widget.textEditingControllerCountry.text,
                                            widget.textEditingControllerAddress.text,
                                        )),
                                  ),
                                  ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }

}
