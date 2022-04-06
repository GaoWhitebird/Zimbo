import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/auth/pantry_item_photo_view_model.dart';
import 'package:zimbo/views/items/item_recyclable_photo_view.dart';

// ignore: must_be_immutable
class PantryItemPhotoView extends StatefulWidget {
  List<RecyclableItemModel> itemList = [];
  PantryItemPhotoView(this.itemList, {Key? key}) : super(key: key);

  @override
  State<PantryItemPhotoView> createState() => _PantryItemPhotoViewState();
}

class _PantryItemPhotoViewState extends State<PantryItemPhotoView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PantryItemPhotoViewModel>.reactive(
      viewModelBuilder: () => PantryItemPhotoViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context, widget.itemList),
    );
  }

  buildWidget(
      BuildContext context, PantryItemPhotoViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorBlue);
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Image.asset(ImageUtils.imgIcLogo,
                  width: width * 0.15, fit: BoxFit.scaleDown),
              backgroundColor: ColorUtils.appColorBlue,
              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            body: Container(
              color: ColorUtils.appColorBlue,
              child: Column(
                children: [
                  textView(StringUtils.txtTakePhoto,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeNormal,
                      fontWeight: FontWeight.w600,
                      isCentered: true,
                      maxLine: 2),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(ImageUtils.imgIcAboutUs, color: ColorUtils.appColorWhite, width: 20, height: 20,),
                          const SizedBox(width: 10,),
                          textViewUnderline(
                            StringUtils.txtWhyINeed,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            isCentered: false,
                          ),
                        ],
                      ),
                    ),
                    onTap: () => model.onClickHelp(context),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: ListView(
                        children: getChildList(model),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: RoundButton(
                        isStroked: false,
                        textContent: StringUtils.txtApply,
                        textSize: SizeUtils.textSizeMedium,
                        radius: 30,
                        onPressed: () => model.onClickNext(context)),
                  ),
                ],
              ),
            )),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }

  List<Widget> getChildList(PantryItemPhotoViewModel model) {
    return model.mList.map((item) {
      return RecyclableItemPhotoView(
          model: item,
          onClickPhoto: () {
            model.onClickPhoto(context, item);
          });
    }).toList();
  }
}
