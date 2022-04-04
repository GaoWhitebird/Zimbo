import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/view_models/auth/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, SplashViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(ImageUtils.imgIcSplash),
              fit: BoxFit.cover
            )    
          ),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(ImageUtils.imgIcLogo, width: width * 0.3, fit: BoxFit.scaleDown),
              ),
            ],
          )
        ),
      ), 
      onWillPop: (){
        return Future.value(false);
      });
  }
}