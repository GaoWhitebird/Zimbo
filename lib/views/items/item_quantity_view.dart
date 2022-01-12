import 'package:flutter/material.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

// ignore: must_be_immutable
class QuantityWidget extends StatefulWidget {
  QuantityWidget({Key? key, required this.model, this.addRemoveClicked}) : super(key: key);

  RecyclableItemModel model;
  Function? addRemoveClicked;
  @override
  QuantityWidgetState createState() => QuantityWidgetState();
}

class QuantityWidgetState extends State<QuantityWidget> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: widget.model.isChecked == '1',
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
                splashColor: ColorUtils.appColorTransparent,
                icon: const Icon(Icons.remove,
                    color: ColorUtils.appColorTextDark, size: 15,),
                onPressed: () {
                  setState(() {
                    if (int.parse(widget.model.count) > 0) {
                      widget.model.count = (int.parse(widget.model.count) - 1).toString();
                    }
                  });
                  if(widget.addRemoveClicked != null){
                    widget.addRemoveClicked!();
                  }
                },
              ),
            ),
            textView(widget.model.count, textColor: ColorUtils.appColorBlack, fontSize: SizeUtils.textSizeMedium),
            Container(
              width: width * 0.08,
              height: width * 0.08,
              alignment: Alignment.center,
              child: IconButton(
                splashRadius: 20,
                splashColor: ColorUtils.appColorTransparent,
                icon: const Icon(Icons.add,
                    color: ColorUtils.appColorTextDark, size: 15),
                onPressed: () {
                  setState(() {
                    widget.model.count = (int.parse(widget.model.count) + 1).toString();
                  });
                  if(widget.addRemoveClicked != null){
                    widget.addRemoveClicked!();
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
