import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/main/sphere_view_model.dart';
import 'package:zimbo/views/items/item_blog.dart';

class SphereView extends StatelessWidget {
  const SphereView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SphereViewModel>.reactive(
      viewModelBuilder: () => SphereViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, SphereViewModel model, Widget? child) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: ColorUtils.appColorBlue,
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: width * 0.05),
                Image.asset(
                  ImageUtils.imgIcSphereHeader,
                  width: width * 0.25,
                  height: width * 0.25,
                ),
                SizedBox(height: width * 0.05),
                Image.asset(
                  ImageUtils.imgIcLogo,
                  width: width * 0.4,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: textView(StringUtils.txtSphere,
                                textColor: ColorUtils.appColorWhite,
                                fontSize: SizeUtils.textSizeNormal,
                                fontWeight: FontWeight.w600,
                                isCentered: true,
                                textAllCaps: true),
                ),
                Container(
                  width: width * 0.15,
                  height: 2,
                  color: ColorUtils.appColorAccent,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: textView(StringUtils.txtWhatNewBlog,
                                textColor: ColorUtils.appColorWhite,
                                fontSize: SizeUtils.textSizeLargeMedium,
                                fontWeight: FontWeight.w600,
                                isCentered: true,
                                textAllCaps: true),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          BlogItem(blgImage: ImageUtils.imgIcBlog1, blgTitle: StringUtils.txtBlogTitle_1, blgDescription: StringUtils.txtBlogDescription_1, blgWidth: width * 0.45,),
                          BlogItem(blgImage: ImageUtils.imgIcBlog2, blgTitle: StringUtils.txtBlogTitle_2, blgDescription: StringUtils.txtBlogDescription_2, blgWidth: width * 0.45,),
                        ],
                      ),
                      BlogItem(blgImage: ImageUtils.imgIcBlog3, blgTitle: StringUtils.txtBlogTitle_3, blgDescription: StringUtils.txtBlogDescription_3, blgWidth: width * 0.95,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
