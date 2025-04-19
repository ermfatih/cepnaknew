import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key, this.height});
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? 0.40.sh,
        child: Center(
            child: CircularProgressIndicator()));
  }
}
