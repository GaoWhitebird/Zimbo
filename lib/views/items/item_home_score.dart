import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

class HomeScoreItem extends StatefulWidget {
  const HomeScoreItem({Key? key, required this.model}) : super(key: key);

  final UserModel? model;

  @override
  _HomeScoreItemState createState() => _HomeScoreItemState();
}

class _HomeScoreItemState extends State<HomeScoreItem> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Card(
        elevation: 0.0,
        color: ColorUtils.appColorTransparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
                width: 1, color: ColorUtils.appColorTransparent)),
        child: Stack(
          children: <Widget>[
            CircleAvatar(
                backgroundColor: ColorUtils.appColorWhite,
                radius: width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      ImageUtils.imgIcDashboardHeader,
                      width: width * 0.15,
                      height: width * 0.15,
                    ),
                    textView(StringUtils.txtTotalReuseActivity,
                        fontSize: SizeUtils.textSizeSmall,
                        textColor: ColorUtils.appColorBlack),
                    textView(
                        widget.model == null
                            ? '0'
                            : widget.model?.userScore,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeUtils.textSizeLarge,
                        textColor: ColorUtils.appColorAccent),
                  ],
                )),
            Row(
              children: <Widget>[
                Container(
                  height: width * 0.2,
                  padding:
                      EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                  child: CircleAvatar(
                    radius: width * 0.08,
                    backgroundColor: ColorUtils.appColorOrange_10,
                    child: SvgPicture.asset(ImageUtils.imgIcStar,
                        width: width * 0.08,
                        height: width * 0.08,
                        fit: BoxFit.fill),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textView(StringUtils.txtYourScore,
                        fontSize: SizeUtils.textSizeMedium,
                        fontWeight: FontWeight.w600,
                        textColor: ColorUtils.appColorTextDark),
                    textView(StringUtils.txtOnePoint,
                        fontSize: SizeUtils.textSizeSMedium,
                        textColor: ColorUtils.appColorTextLight),
                  ],
                ),
                Expanded(
                    child: Container(
                  height: width * 0.25,
                  alignment: Alignment.center,
                  child: textView(
                      widget.model == null ? '0' : widget.model?.userScore,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeUtils.textSizeLarge,
                      textColor: ColorUtils.appColorAccent),
                ))
              ],
            ).visible(false),
          ],
        ));
  }
}
