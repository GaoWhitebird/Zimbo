import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/main/echo_hub_view_model.dart';

class EcoHubView extends StatelessWidget {
  const EcoHubView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EcoHubViewModel>.reactive(
      viewModelBuilder: () => EcoHubViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

buildWidget(BuildContext context, EcoHubViewModel model, Widget? child) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          child: textView(StringUtils.txtEcoHub),
        ),
      ]),
    );
  }
}