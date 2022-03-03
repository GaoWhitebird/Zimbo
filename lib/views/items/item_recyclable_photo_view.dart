import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/views/items/item_quantity_view.dart';

// ignore: must_be_immutable
class RecyclableItemPhotoView extends StatefulWidget {
  RecyclableItemPhotoView({Key? key, required this.model, this.onClickPhoto}) : super(key: key);

  final RecyclableItemModel model;
  Function? onClickPhoto;

  @override
  _RecyclableItemPhotoViewState createState() => _RecyclableItemPhotoViewState();
}

class _RecyclableItemPhotoViewState extends State<RecyclableItemPhotoView> {
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
                  QuantityWidget(model: widget.model).visible(false),
                ],
              )
            ),
            Container(
              height: width * 0.2 + 20,
              alignment: Alignment.center,
              child: widget.model.userRecyclableImage != "" ? SvgPicture.asset(ImageUtils.imgIcCheckSigngle) : Container(color: ColorUtils.appColorTransparent,),
            ),
            IconButton(
              splashRadius: 25,
              icon: const Icon(
                Icons.photo_camera_outlined,
                color: ColorUtils.appColorTextTitle,
              ),
              onPressed: () {
                if(widget.onClickPhoto != null){
                  widget.onClickPhoto!();
                }
              },
            )  
          ],
        ),
      )
    );
  }
}