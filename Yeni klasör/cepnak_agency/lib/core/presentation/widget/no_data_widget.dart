import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i18n_extension/default.i18n.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.height});
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 0.40.sh,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: const Icon(Icons.do_not_disturb_alt),
          ),
          Text('There is no data'.i18n,
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
