import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/views/items/item_quantity_view.dart';

class RecyclableItemView extends StatefulWidget {
  RecyclableItemView({Key? key, required this.model}) : super(key: key);

  final RecyclableItemModel model;

  @override
  _RecyclableItemViewState createState() => _RecyclableItemViewState();
}

class _RecyclableItemViewState extends State<RecyclableItemView> {
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
                  textView(widget.model.name, fontSize: SizeUtils.textSizeMedium),
                  const SizedBox(height: 5),
                  QuantityWidget(model: widget.model),
                ],
              )
            ),
            Container(
              height: width * 0.2 + 20,
              alignment: Alignment.topRight,
              child: IconButton(
                icon: widget.model.isChecked == '1' ? SvgPicture.asset(ImageUtils.imgIcCheckOn) : SvgPicture.asset(ImageUtils.imgIcCheckOff),
                alignment: Alignment.topRight,
                splashColor: ColorUtils.appColorTransparent,
                onPressed: () {
                  setState(() {
                    if(widget.model.isChecked == '1'){
                      widget.model.count = '0';
                    }
                    widget.model.isChecked == '1' ? widget.model.isChecked = '0' : widget.model.isChecked = '1';
                  });
                },
              ),
            ),  
          ],
        ),
      )
    );
  }
}