import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:zimbo/model/common/about_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

// ignore: must_be_immutable
class AboutUSItemView extends StatelessWidget {
  AboutUSItemView({ Key? key, required this.model}) : super(key: key);

  AboutModel model;

  @override
  Widget build(BuildContext context) {
 return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: textView(model.title, textColor: ColorUtils.appColorTextDark, fontSize: SizeUtils.textSizeMedium, fontWeight: FontWeight.w600)),
                collapsed: Container(),
                expanded: textView(model.description, textColor: ColorUtils.appColorTextLight, fontSize: SizeUtils.textSizeSMedium, maxLine: 50),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
            Container(height: 1, color: ColorUtils.appColorTextWhite,)
          ],
        ),
      ));
  }
}