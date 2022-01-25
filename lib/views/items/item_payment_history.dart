import 'package:flutter/material.dart';
import 'package:zimbo/model/common/payment_history_item_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/time_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

class PaymentHistoryItem extends StatefulWidget {
  const PaymentHistoryItem({Key? key, required this.model}) : super(key: key);

  final PaymentHistoryItemModel model;


  @override
  State<StatefulWidget> createState() => _PaymentHistoryItemState();
}

class _PaymentHistoryItemState extends State<PaymentHistoryItem> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget image = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: width * 0.2,
        height: width * 0.2,
        color: ColorUtils.appColorWhite,
        child: widget.model.status == 'success' ? const Icon(Icons.check_circle_outline_rounded, size: 30, color: ColorUtils.appColorAccent,)
          : const Icon(Icons.remove_circle_outline, size: 30, color: ColorUtils.appColorRedDark,)
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
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: ColorUtils.appColorTextLight,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      textView(readTimestampYYYYDD(widget.model.time),
                          fontSize: SizeUtils.textSizeSmall,
                          textColor: ColorUtils.appColorTextLight),
                      const SizedBox(width: 5),
                      const Icon(Icons.timer,
                          color: ColorUtils.appColorTextLight, size: 18),
                      const SizedBox(width: 5),
                      textView(readTimestampHH(widget.model.time),
                          fontSize: SizeUtils.textSizeSmall,
                          textColor: ColorUtils.appColorTextLight),
                    ],
                  )
                ],
              )),
              Container(
                  height: width * 0.2 + 20,
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textView(StringUtils.txtMinusUSD,
                          fontSize: SizeUtils.textSizeMedium,
                          fontWeight: FontWeight.w500,
                          textColor: ColorUtils.appColorTextDark),
                      textView(widget.model.amount,
                          fontSize: SizeUtils.textSizeMedium,
                          textColor: ColorUtils.appColorTextDark,
                          fontWeight: FontWeight.w500),
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
