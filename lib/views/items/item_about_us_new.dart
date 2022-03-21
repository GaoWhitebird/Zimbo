import 'package:flutter/material.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

class AboutUsNewItem extends StatefulWidget {
  AboutUsNewItem(
      {Key? key,
      required this.blgImage,
      required this.blgTitle,
      required this.blgDescription,
      required this.blgWidth})
      : super(key: key);

  final String blgImage;
  final String blgTitle;
  final String blgDescription;
  // ignore: prefer_typing_uninitialized_variables
  final blgWidth;

  @override
  State<AboutUsNewItem> createState() => _AboutUsNewItemState();
}

class _AboutUsNewItemState extends State<AboutUsNewItem> {
  @override
  Widget build(BuildContext context) {
    Widget image = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Image.asset(
        widget.blgImage,
        width: widget.blgWidth,
        fit: BoxFit.cover,
      ),
    );

    return Container(
        padding: const EdgeInsets.all(5),
        width: widget.blgWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 5),
            textView(widget.blgTitle,
                textColor: ColorUtils.appColorWhite,
                fontSize: SizeUtils.textSizeNormal,
                fontWeight: FontWeight.w600,
                maxLine: 2,
                isCentered: true),
            image,
            const SizedBox(height: 5),
            textView(widget.blgDescription,
                textColor: ColorUtils.appColorWhite,
                fontSize: SizeUtils.textSizeSmall,
                fontWeight: FontWeight.w400,
                maxLine: 20),
          ],
        ));
  }
}
