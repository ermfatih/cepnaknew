import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/auth/onboard/onboard_controller.dart';
import 'package:cepnak/product/constant/cache_enums.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:cepnak/product/i18n/strings.g.dart';
import 'package:cepnak/product/init/cache/cache_manager.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({super.key});

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  OnboardController _controller=Get.put(OnboardController());
  double opacity=0;
  @override
  void initState() {
    super.initState();
    _controller.changeFirstTime();
    Future.microtask(() {setState(() {opacity=1;});});
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: context.paddingLowAll,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(CacheManager.instance.getStringValue(CacheKeys.value) ?? 'burası boş değer'),
              Center(child: Image.asset(PngItems.rightcodelogo.pngPath,width: 50.w,height: 50.h)),
              SizedBox(height: 50.h,),
              AnimatedOpacity(
                duration: Duration(seconds: 2),
                  opacity: opacity,
                  child: Center(child: Image.asset(PngItems.truck.pngPath,width: 270.w,height: 206.h))),
              Text('Lorem İpsum dolar',style: context.myTheme.textTheme.headlineMedium),
              Text('datsdfsdfsdfsdfsdfsdfsdfa',style: context.myTheme.textTheme.bodySmall),
              Center(child:GreenElevatedButton(onPressed: () {
                NavigatorManager.instance.pushReplacement(NavigatesRoutes.register);
              },text: letsStart.i18n),),
            ],
          ),
        ),
      ),
    );
  }


}


