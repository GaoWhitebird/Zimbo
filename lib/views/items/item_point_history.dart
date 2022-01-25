import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zimbo/model/common/point_item_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/time_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

class PointHistoryItem extends StatefulWidget {
  const PointHistoryItem({Key? key, required this.model}) : super(key: key);

  final PointItemModel model;

  @override
  _PointHistoryItemState createState() => _PointHistoryItemState();
}

class _PointHistoryItemState extends State<PointHistoryItem> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget image = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: CachedNetworkImage(
        imageUrl: widget.model.image,
        width: width * 0.2,
        height: width * 0.2,
        fit: BoxFit.fill,
        placeholder: (context, url) => Lottie.asset(
          ImageUtils.imgLogingImage,
          width: width * 0.2,
          height: width * 0.2,
          fit: BoxFit.fill,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(width * 0.02),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                child: image,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textView(widget.model.name,
                      fontSize: SizeUtils.textSizeMedium, fontWeight: FontWeight.w600),
                  const SizedBox(height: 5),
                  Row(
                    children: <Widget> [
                      const Icon(Icons.calendar_today_outlined, color: ColorUtils.appColorTextLight, size: 18,),
                      const SizedBox(width: 5),
                      textView(readTimestampYYYYDD(widget.model.timestamp), fontSize: SizeUtils.textSizeSmall, textColor: ColorUtils.appColorTextLight),
                      const SizedBox(width: 5),
                      const Icon(Icons.timer, color: ColorUtils.appColorTextLight, size: 18),
                      const SizedBox(width: 5),
                      textView(readTimestampHH(widget.model.timestamp), fontSize: SizeUtils.textSizeSmall, textColor: ColorUtils.appColorTextLight),
                    ],
                  )
                ],
              )),
              Container(
                  height: width * 0.2 + 20,
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textView(StringUtils.txtPlusOne,
                          fontSize: SizeUtils.textSizeNormal,
                          fontWeight: FontWeight.w500,
                          textColor: ColorUtils.appColorAccent),
                      textView(
                          StringUtils.txtPts,
                          fontSize: SizeUtils.textSizeSMedium,
                          textColor: ColorUtils.appColorTextLight,
                          fontWeight: FontWeight.w400),
                    ],
                  )),
            ],
          ),
        ),
        Container(
          height: 0.5,
          color: ColorUtils.appColorTextWhite,
        )
      ],
    );
  }
}
