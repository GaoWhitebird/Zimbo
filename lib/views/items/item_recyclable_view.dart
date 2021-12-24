import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:zimbo/model/recyclable_item_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

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
                icon: widget.model.isChecked ? SvgPicture.asset(ImageUtils.imgIcCheckOn) : SvgPicture.asset(ImageUtils.imgIcCheckOff),
                alignment: Alignment.topRight,
                splashColor: ColorUtils.appColorTransparent,
                onPressed: () {
                  setState(() {
                    if(widget.model.isChecked){
                      widget.model.count = 0;
                    }
                    widget.model.isChecked = !widget.model.isChecked;
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

// ignore: must_be_immutable
class QuantityWidget extends StatefulWidget {
  QuantityWidget({Key? key, required this.model}) : super(key: key);

  RecyclableItemModel model;
  @override
  QuantityWidgetState createState() => QuantityWidgetState();
}

class QuantityWidgetState extends State<QuantityWidget> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: widget.model.isChecked,
      child: Container(
        height: width * 0.1,
        alignment: Alignment.center,
        width: width * 0.25,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: ColorUtils.appColorTextWhite)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width * 0.08,
              height: width * 0.08,
              alignment: Alignment.center,
              child: IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.remove,
                    color: ColorUtils.appColorTextDark, size: 15,),
                onPressed: () {
                  setState(() {
                    if (widget.model.count > 0) {
                      widget.model.count = widget.model.count - 1;
                    }
                  });
                },
              ),
            ),
            textView(widget.model.count.toString(), textColor: ColorUtils.appColorBlack, fontSize: SizeUtils.textSizeMedium),
            Container(
              width: width * 0.08,
              height: width * 0.08,
              alignment: Alignment.center,
              child: IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.add,
                    color: ColorUtils.appColorTextDark, size: 15),
                onPressed: () {
                  setState(() {
                    widget.model.count = widget.model.count + 1;
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
