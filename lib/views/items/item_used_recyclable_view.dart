import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/views/items/item_quantity_view.dart';

class UsedRecyclableItemView extends StatefulWidget {
  UsedRecyclableItemView({Key? key, required this.model, required this.onDelete, required this.onAddRemove}) : super(key: key);

  final RecyclableItemModel model;
  final VoidCallback onDelete;
  final Function onAddRemove;

  @override
  _UsedRecyclableItemViewState createState() => _UsedRecyclableItemViewState();
}

class _UsedRecyclableItemViewState extends State<UsedRecyclableItemView> {
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
          side: const BorderSide(width: 1, color: ColorUtils.appColorTextWhite),
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
                        fontSize: SizeUtils.textSizeMedium),
                    const SizedBox(height: 5),
                    QuantityWidget(model: widget.model, addRemoveClicked: widget.onAddRemove,),
                  ],
                )),
                Container(
                  height: width * 0.2 + 20,
                  padding: const EdgeInsets.fromLTRB(0, 0, 50, 10),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      textView(StringUtils.txtUsed, fontSize: SizeUtils.textSizeSmall, textColor: ColorUtils.appColorTextWhite),
                      textView(widget.model.usedCount + ' ' + StringUtils.txtTimes, fontSize: SizeUtils.textSizeSMedium, textColor: ColorUtils.appColorTextDark, fontWeight: FontWeight.w500),
                    ],
                  )
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                splashRadius: 25,
                onPressed: widget.onDelete, 
                icon: const Icon(Icons.close, size: 20,)),
            ),
            
          ],
        ));
  }
}
