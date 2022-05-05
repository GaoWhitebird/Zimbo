import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';
import 'package:stacked/stacked.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/auth/select_shopping_day_view_model.dart';

class SelectShoppingDayView extends StatelessWidget {
  const SelectShoppingDayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectShoppingDayViewModel>.reactive(
      viewModelBuilder: () => SelectShoppingDayViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, SelectShoppingDayViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorBlue);
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Image.asset(ImageUtils.imgIcLogo,
                  width: width * 0.15, fit: BoxFit.scaleDown),
              backgroundColor: ColorUtils.appColorBlue,
              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            body: Container(
              color: ColorUtils.appColorBlue,
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.fromLTRB(width * 0.1, 0, width * 0.1, 0),
                    child: textView(StringUtils.txtWhenShopping,
                        textColor: ColorUtils.appColorWhite,
                        fontSize: SizeUtils.textSizeNormal,
                        fontWeight: FontWeight.w600,
                        isCentered: true,
                        maxLine: 2),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(children: <Widget>[
                          WeekdaySelector(
                            fillColor: ColorUtils.appColorWhite,
                            selectedFillColor: ColorUtils.appColorAccent,
                            color: ColorUtils.appColorBlack,
                            selectedColor: ColorUtils.appColorWhite,
                            onChanged: (int day) {
                              model.weekDayChanged(day);
                            },
                            values: model.weekDayValues,
                            firstDayOfWeek: 0,
                            shortWeekdays: model.weekDayStringList,
                          ),
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: model.isChecked
                                        ? SvgPicture.asset(
                                            ImageUtils.imgIcCheckOn)
                                        : SvgPicture.asset(
                                            ImageUtils.imgIcCheckOff),
                                    alignment: Alignment.center,
                                    splashColor: ColorUtils.appColorTransparent,
                                    onPressed: () {
                                      model.onSetChecked(!model.isChecked);
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      model.onSetChecked(!model.isChecked);
                                    },
                                    child: textView(
                                        StringUtils.txtNoSpecificDay,
                                        textColor: ColorUtils.appColorWhite,
                                        fontSize: SizeUtils.textSizeSMedium,
                                        fontWeight: FontWeight.w400,
                                        maxLine: 1),
                                  )
                                ],
                              )),
                          Expanded(
                              child: Container(
                            alignment: Alignment.center,
                            child: textView(StringUtils.txtReminderTheseDays,
                                textColor: ColorUtils.appColorWhite,
                                fontSize: SizeUtils.textSizeMedium,
                                fontWeight: FontWeight.w600,
                                isCentered: true,
                                maxLine: 4),
                          )).visible(!model.isChecked),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      textView(
                                          StringUtils.txtReminderShoppingBags,
                                          textColor: ColorUtils.appColorWhite,
                                          fontSize: SizeUtils.textSizeMedium,
                                          fontWeight: FontWeight.w600,
                                          isCentered: true,
                                          maxLine: 4),
                                      const SizedBox(height: 15,),
                                      GroupButton(
                                        options: GroupButtonOptions(
                                          unselectedColor: ColorUtils.appColorWhite,
                                          selectedColor: ColorUtils.appColorAccent,
                                          buttonWidth: width * 0.4,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          runSpacing: 0,
                                        ),
                                       
                                        isRadio: true,
                                        onSelected: (buttons, index, isSelected) {
                                          model.onGroupSelected(index, isSelected);
                                        },
                                        buttons: const [
                                          StringUtils.txtOnceAWeek,
                                          StringUtils.txtTwiceAWeek,
                                          StringUtils.txtOnMondays,
                                          StringUtils.txtOnWeekends,
                                        ],
                                        
                                      )
                                    ],
                                  ))).visible(model.isChecked),
                        ])),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: RoundButton(
                            isStroked: false,
                            textContent: StringUtils.txtApply,
                            textSize: SizeUtils.textSizeMedium,
                            radius: 30,
                            onPressed: () => model.onClickApply(context)),
                      ),
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          alignment: Alignment.center,
                          child: textViewUnderline(
                            StringUtils.txtNotNow,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            isCentered: false,
                          ),
                        ),
                        onTap: () => model.onClickSkip(context),
                      ),
                    ],
                  )
                ],
              ),
            )),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
