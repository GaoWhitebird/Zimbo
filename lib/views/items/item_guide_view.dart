import 'package:flutter/material.dart';
import 'package:zimbo/model/common/guide_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

// ignore: must_be_immutable
class ItemGuideView extends StatelessWidget {
  ItemGuideView({Key? key, required this.model, this.onTap}) : super(key: key);

  GuideModel model;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: model.backgroundColor,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: width * 0.03,),
              CircleAvatar(
                  backgroundColor: ColorUtils.appColorWhite,
                  radius: width * 0.08,
                  child: Container(
                    child: textView(model.id,
                        fontSize: SizeUtils.textSizeXXLarge,
                        fontWeight: FontWeight.bold,
                        textColor: model.backgroundColor),
                  )),
              Image.asset(model.imageStr!,
                  width: width * 0.25, height: width * 0.3, fit: BoxFit.scaleDown),
            ],
          ),
          Container(
            width: width * 0.75,
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                textViewUnderline(model.title,
                    fontSize: SizeUtils.textSizeLargeMedium,
                    fontWeight: FontWeight.bold,
                    textColor: ColorUtils.appColorWhite,
                    maxLine: 3,
                    isCentered: false,
                    textAlign: TextAlign.end),
                const SizedBox(height: 10,),
                textView(model.description,
                    fontSize: SizeUtils.textSizeSmall,
                    fontWeight: FontWeight.w500,
                    textColor: ColorUtils.appColorWhite,
                    maxLine: 10,
                    isCentered: false,
                    textAlign: TextAlign.end),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
