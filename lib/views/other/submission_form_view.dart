import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/submission_form_view_model.dart';

class SubmissionFormView extends StatelessWidget {
  SubmissionFormView({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerDescription =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubmissionFormViewModel>.reactive(
      viewModelBuilder: () => SubmissionFormViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, SubmissionFormViewModel model, Widget? child) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorUtils.appColorBlue,
      appBar: AppBar(
            title: textView(StringUtils.txtSubmissionForm,
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
      body: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.05,
                  alignment: Alignment.center,
                  child: textViewUnderline(StringUtils.txtShareIdea,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeNormal,
                      fontWeight: FontWeight.w600,
                      isCentered: true),
                ),
                Container(
                  height: height * 0.1,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: textView(StringUtils.txtDescribeYourProblem,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeSmall,
                      fontWeight: FontWeight.w300,
                      isCentered: true,
                      maxLine: 2),
                ),
                Container(
                  height: height * 0.1,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: textView(StringUtils.txtSupportMail,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeSMedium,
                      fontWeight: FontWeight.w500,
                      isCentered: true,
                      maxLine: 1),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
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
                    height: height * 0.75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              EditTextField(
                                hintText: StringUtils.txtDescription,
                                isPassword: false,
                                isSecure: false,
                                mController: textEditingControllerDescription,
                                borderColor: ColorUtils.appColorBlack_10,
                                maxLine: 5,
                                isCentered: false,
                              ),
                              Container(
                                height: height * 0.2,
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorUtils.appColorPrimaryDark,
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    model.imagePath.isNotEmpty
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.file(
                                              new File(model.imagePath),
                                              width: width,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Container(
                                            color:
                                                ColorUtils.appColorTransparent,
                                          ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: ElevatedButton.icon(
                                          onPressed: () =>
                                              model.onClickAddImage(context),
                                          icon: const Icon(
                                            Icons.file_upload_outlined,
                                            color: ColorUtils.appColorTextLight,
                                          ),
                                          label: textView(
                                              StringUtils.txtUploadScreenshot,
                                              textColor:
                                                  ColorUtils.appColorBlack,
                                              fontSize:
                                                  SizeUtils.textSizeSMedium,
                                              fontWeight: FontWeight.w500,
                                              isCentered: true),
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              primary: ColorUtils
                                                  .appColorTransparent,
                                              padding: const EdgeInsets.only(
                                                  left: 30,
                                                  right: 30,
                                                  top: 10,
                                                  bottom: 10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ))),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: RoundButton(
                                    isStroked: false,
                                    textContent: StringUtils.txtSend,
                                    textSize: SizeUtils.textSizeMedium,
                                    radius: 30,
                                    onPressed: () => model.onClickSend(context,
                                        textEditingControllerDescription.text)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ]),
        ),
      ]),
    );
  }
}
