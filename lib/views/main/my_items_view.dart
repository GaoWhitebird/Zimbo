import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/main/my_items_view_model.dart';

class MyItemsView extends StatelessWidget {
  const MyItemsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyItemsViewModel>.reactive(
      viewModelBuilder: () => MyItemsViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, MyItemsViewModel model, Widget? child) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          child: textView(StringUtils.txtMyItems),
        ),
      ]),
    );
  }
}