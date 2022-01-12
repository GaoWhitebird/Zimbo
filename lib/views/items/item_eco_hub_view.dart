import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:zimbo/model/common/eco_hub_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

// ignore: must_be_immutable
class EcoHubItemView extends StatelessWidget {
  EcoHubItemView({Key? key, required this.model}) : super(key: key);

  EcoHubModel model;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                  child: textView(model.title,
                      textColor: ColorUtils.appColorTextDark,
                      fontSize: SizeUtils.textSizeMedium,
                      fontWeight: FontWeight.w600)),
              collapsed: Container(),
              expanded: Column(
                children: [
                  const SizedBox(height: 10,),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl: model.image,
                      width: width,
                      height: width * 0.5,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  textView(model.description,
                      textColor: ColorUtils.appColorTextLight,
                      fontSize: SizeUtils.textSizeSMedium,
                      maxLine: 50),
                ],
              ),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 1,
            color: ColorUtils.appColorTextWhite,
          )
        ],
      ),
    ));
  }
}
