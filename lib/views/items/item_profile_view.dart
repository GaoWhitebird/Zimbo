import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

// ignore: must_be_immutable
class ProfileViewItem extends StatelessWidget {
  ProfileViewItem({ Key? key, required this.imageStr, required this.titleStr, required this.contentStr, this.onTap}) : super(key: key);

  final String imageStr;
  final String titleStr;
  final String contentStr;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(imageStr, color: ColorUtils.appColorAccent),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      textView(titleStr, textColor: ColorUtils.appColorTextLight, fontSize: SizeUtils.textSizeSmall, isCentered: false),
                      textView(contentStr, textColor: ColorUtils.appColorTextDark, fontSize: SizeUtils.textSizeSMedium, isCentered: false),
                    ],
                  )
                  
                ),
              ],
            ),
          ),
          Container(height: 1, color: ColorUtils.appColorGreyLight,)
        ],
      ),
      onTap: onTap,
    );
  }
}