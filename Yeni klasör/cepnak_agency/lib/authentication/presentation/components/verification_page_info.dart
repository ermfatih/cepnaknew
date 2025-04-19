import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i18n_extension/default.i18n.dart';

class VerificationPageInfo extends StatelessWidget {
  final String phoneNumber;
  const VerificationPageInfo({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Verification Code".i18n,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 4.h),
        Text(
          'Please enter the verification code sent to your phone number'.i18n,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            phoneNumber,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
