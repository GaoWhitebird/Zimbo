import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/view_models/other/social_view_model.dart';

class SocialView extends StatelessWidget {
  const SocialView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SocialViewModel>.reactive(
      viewModelBuilder: () => SocialViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, SocialViewModel model, Widget? child) {
    
  }
}