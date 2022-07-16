import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zimbo/model/common/summary_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

// ignore: must_be_immutable
class SummaryItemView extends StatefulWidget {
  SummaryItemView({Key? key, required this.model,}) : super(key: key);

  final SummaryModel model;

  @override
  _SummaryItemViewState createState() => _SummaryItemViewState();
}

class _SummaryItemViewState extends State<SummaryItemView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget image = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: CachedNetworkImage(
        imageUrl: widget.model.image!,
        width: width * 0.2,
        height: width * 0.2,
        fit: BoxFit.fill,
        placeholder: (context, url) => Lottie.asset(ImageUtils.imgLogingImage, width: width * 0.2, height: width * 0.2, fit: BoxFit.fill,),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );

    return Card(
      elevation: 0.0,
      color: ColorUtils.appColorWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(width: 1, color: ColorUtils.appColorTextWhite),
      ),
      child: SizedBox(
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
                  textView(widget.model.name, fontSize: SizeUtils.textSizeSMedium, fontWeight: FontWeight.w400, maxLine: 2),
                  const SizedBox(height: 5,),
                  textView(widget.model.value, fontSize: SizeUtils.textSizeLargeMedium, fontWeight: FontWeight.w500, maxLine: 2),
                ],
              )
            ),
          ],
        ),
      )
    );
  }
}