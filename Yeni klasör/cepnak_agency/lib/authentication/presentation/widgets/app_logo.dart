import 'package:cepnak_agency/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.isLoginPage = true,
  });
  final bool isLoginPage;

  @override
  Widget build(BuildContext context) {
    return Image.asset(Assets.png.logocepnak.path,height: 160.h,width: 210.w,fit: BoxFit.cover,);
  }
}
