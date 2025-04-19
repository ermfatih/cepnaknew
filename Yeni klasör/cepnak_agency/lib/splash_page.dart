import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static String get routeName => 'splash';
  static String get routeLocation => '/$routeName';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 200.h,width: 200.w,),
              Image.asset('assets/images/cepnak_splash.png',height: 200.h,width: 200.w,fit: BoxFit.contain),
              const CircularProgressIndicator(),
              Image.asset('assets/images/rightcodelogo.png',width: 50.w,height: 50.h,fit: BoxFit.contain),
              SizedBox(height: 10.h,)
            ],
          ),
        ),
      ),
    );
  }
}
