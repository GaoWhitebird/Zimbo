import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

class AdditionalRecyclableItemView extends StatefulWidget {
  AdditionalRecyclableItemView(
      {Key? key,
      required this.model,
      required this.onDelete,
      required this.onAddRemove})
      : super(key: key);

  final RecyclableItemModel model;
  final VoidCallback onDelete;
  final Function onAddRemove;

  @override
  _AdditionalRecyclableItemViewState createState() =>
      _AdditionalRecyclableItemViewState();
}

class _AdditionalRecyclableItemViewState
    extends State<AdditionalRecyclableItemView> {
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

    return Card(
        elevation: 0.0,
        color: ColorUtils.appColorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(width: 1, color: ColorUtils.appColorWhite),
        ),
        child: Stack(
          children: [
            Row(
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
                        fontSize: SizeUtils.textSizeMedium,
                        fontWeight: FontWeight.w500),
                  ],
                )),
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: ColorUtils.appColorAccent,
                      child: GestureDetector(
                        onTap: () {
                          widget.onAddRemove();
                        },
                        child: const Icon(
                          Icons.add,
                          color: ColorUtils.appColorWhite,
                          size: 20,
                        ),
                      )),
                )
              ],
            ),
          ],
        ));
  }
}
