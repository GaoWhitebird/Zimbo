import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/views/items/item_quantity_view.dart';

class ScoreRecyclableItemView extends StatefulWidget {
  ScoreRecyclableItemView(
      {Key? key,
      required this.model,
      required this.onDelete,
      required this.onAddRemove})
      : super(key: key);

  final RecyclableItemModel model;
  final VoidCallback onDelete;
  final Function onAddRemove;

  @override
  _ScoreRecyclableItemViewState createState() => _ScoreRecyclableItemViewState();
}

class _ScoreRecyclableItemViewState extends State<ScoreRecyclableItemView> {
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
                    const SizedBox(height: 5),
                    Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textView(StringUtils.txtUsed,
                                fontSize: SizeUtils.textSizeSSmall,
                                textColor: ColorUtils.appColorTextDark),
                            textView(
                                widget.model.usedCount +
                                    ' ' +
                                    StringUtils.txtTimes,
                                fontSize: SizeUtils.textSizeSMedium,
                                textColor: ColorUtils.appColorTextDark,
                                fontWeight: FontWeight.w500),
                          ],
                        )),
                    
                  ],
                )),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: QuantityWidget(
                      model: widget.model,
                      addRemoveClicked: widget.onAddRemove,
                    ).visible(widget.model.isMultiple == '1'),
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
                        }else {
                          widget.model.count = '1';
                        }
                        widget.model.isChecked == '1' ? widget.model.isChecked = '0' : widget.model.isChecked = '1';
                      });
                    },
                  ),
                ).visible(widget.model.isMultiple == '0'),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  splashRadius: 25,
                  onPressed: widget.onDelete,
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                  )),
            ).visible(false),
          ],
        ));
  }
}
