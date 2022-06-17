import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/profile_view_model.dart';
import 'package:zimbo/views/items/item_profile_view.dart';
import 'package:zimbo/views/other/subscription/get_keychain_view.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, ProfileViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
            backgroundColor: ColorUtils.appColorBlue,
            appBar: AppBar(
              title: textView(StringUtils.txtProfile,
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
                                child: Image.network(
                                  model.imagePath,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                                size: Size.fromRadius(height * 0.1),
                              )),
                            )
                          : Container(
                              color: ColorUtils.appColorTransparent,
                            ),
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
                      ).visible(model.userModel == null ||
                          model.userModel!.userImage!.isEmpty),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: DottedBorder(
                            color: ColorUtils.appColorTextWhite,
                            strokeWidth: 1,
                            borderType: BorderType.Circle,
                            radius: const Radius.circular(10),
                            child: GestureDetector(
                                //onTap: () => model.onClickAddPhoto(context),
                                )),
                      ).visible(model.userModel == null ||
                          model.userModel!.userImage!.isEmpty),
                    ])),
                textView(
                    model.userModel == null ? '' : model.userModel!.userName,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeUtils.textSizeMedium,
                    textColor: ColorUtils.appColorWhite,
                    isCentered: true),
                textView(
                    model.userModel == null ? '' : model.userModel!.country,
                    fontWeight: FontWeight.w400,
                    fontSize: SizeUtils.textSizeSMedium,
                    textColor: ColorUtils.appColorWhite,
                    isCentered: true),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      ProfileViewItem(
                          imageStr: ImageUtils.imgIcPhone,
                          titleStr: StringUtils.txtMobilePhone,
                          contentStr: model.userPhone),
                      ProfileViewItem(
                          imageStr: ImageUtils.imgIcMail,
                          titleStr: StringUtils.txtEmailAddress,
                          contentStr: model.userEmail),
                      ProfileViewItem(
                          imageStr: ImageUtils.imgIcAddress,
                          titleStr: StringUtils.txtAddress,
                          contentStr: model.userAddress),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(15),
                                    child: GestureDetector(
                                      child: textViewUnderline(
                                        StringUtils.txtResetScore,
                                        textColor: ColorUtils.appColorWhite,
                                        fontSize: SizeUtils.textSizeMedium,
                                        fontWeight: FontWeight.w500,
                                        isCentered: false,
                                      ),
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (BuildContext dlgContext) =>
                                            CustomDialog(
                                                title: StringUtils.txtWarning,
                                                description: StringUtils
                                                    .txtDoYouWantToResetScore,
                                                okButtonStr:
                                                    StringUtils.txtReset,
                                                cancelButtonStr:
                                                    StringUtils.txtCancel,
                                                okClicked: () {
                                                  model.onClickReset(context);
                                                }),
                                      ),
                                    ),
                                  ).visible(false),
                                  Container(
                                    margin: const EdgeInsets.all(15),
                                    child: GestureDetector(
                                      child: textViewUnderline(
                                        StringUtils.txtZimboKeychain,
                                        textColor: ColorUtils.appColorWhite,
                                        fontSize: SizeUtils.textSizeMedium,
                                        fontWeight: FontWeight.w500,
                                        isCentered: false,
                                      ),
                                      onTap: () {
                                        GetKeychainView().launch(context);
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(15),
                                    child: GestureDetector(
                                      child: textViewUnderline(
                                        StringUtils.txtDeleteProfile,
                                        textColor: ColorUtils.appColorWhite,
                                        fontSize: SizeUtils.textSizeMedium,
                                        fontWeight: FontWeight.w500,
                                        isCentered: false,
                                      ),
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (BuildContext dlgContext) =>
                                            CustomDialog(
                                                title: StringUtils.txtWarning,
                                                description: StringUtils
                                                    .txtDoYouWantToDeleteProfile,
                                                okButtonStr:
                                                    StringUtils.txtDelete,
                                                cancelButtonStr:
                                                    StringUtils.txtCancel,
                                                okClicked: () {
                                                  model.onClickDelete(context);
                                                }),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            )),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
