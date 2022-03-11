import 'package:flutter/material.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

class BlogItem extends StatefulWidget {
  BlogItem(
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
  State<BlogItem> createState() => _BlogItemState();
}

class _BlogItemState extends State<BlogItem> {
  @override
  Widget build(BuildContext context) {
    Widget image = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Image.asset(
        widget.blgImage,
        width: widget.blgWidth,
        height: widget.blgWidth,
        fit: BoxFit.fill,
      ),
    );

    return Container(
        padding: const EdgeInsets.all(5),
        width: widget.blgWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            image,
            const SizedBox(height: 5),
            textView(widget.blgTitle,
                textColor: ColorUtils.appColorAccent,
                fontSize: SizeUtils.textSizeMedium,
                fontWeight: FontWeight.w600,
                maxLine: 2),
            const SizedBox(height: 5),
            textView(widget.blgDescription,
                textColor: ColorUtils.appColorWhite,
                fontSize: SizeUtils.textSizeSmall,
                fontWeight: FontWeight.w400,
                maxLine: 10),
          ],
        ));
  }
}
