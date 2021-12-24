import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

// ignore: must_be_immutable
class MenuViewItem extends StatelessWidget {
  MenuViewItem({ Key? key, required this.imageStr, required this.titleStr, this.onTap}) : super(key: key);

  final String imageStr;
  final String titleStr;
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
                SvgPicture.asset(imageStr, color: ColorUtils.appColorBlack),
                const SizedBox(width: 20),
                Expanded(
                  child: textView(titleStr, textColor: ColorUtils.appColorTextDark, fontSize: SizeUtils.textSizeMedium),
                ),
                const Icon(Icons.navigate_next_rounded, color: ColorUtils.appColorTextLight),
              ],
            ),
          ),
          Container(height: 1, color: ColorUtils.appColorTextWhite,)
        ],
      ),
      onTap: onTap,
    );
  }
}