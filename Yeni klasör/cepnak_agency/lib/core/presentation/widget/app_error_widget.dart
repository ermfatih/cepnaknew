import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:lottie/lottie.dart';


class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.5.sh,child:Column(
      children: [
        const Icon(Icons.error),
        //Lottie.asset(Assets.lottie.noData),
        Text('Something went wrong'.i18n,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],)
    );
  }
}
