import 'package:cepnak/features/auth/splash/splash_controller.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashController _controller=Get.put(SplashController());
  @override
  void initState() {
    super.initState();
    _controller.checkUserSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff2AA14A),
        body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 200.h,),
                  Image.asset(PngItems.cepnaklogo.pngPath, width: 200.w, height: 200.h),
                  SizedBox(height: 10.h,),
                  CircularProgressIndicator(),
                  SizedBox(height: 150.h,),
                  Image.asset(PngItems.rightcodelogo.pngPath, width: 50.w, height: 50.h),
                  SizedBox(height: 10.h,),
                ],
              ),
            )));
  }
}
