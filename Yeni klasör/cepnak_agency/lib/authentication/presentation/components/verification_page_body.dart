import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../core/presentation/widget/dynamic_button.dart';
import '../../../core/presentation/widget/pin_input.dart';
import '../../application/authtication_provider.dart';
import '../../application/counter_clock_provider.dart';
import '../../provider/auth_notifier.dart';

class VerificationPageBody extends ConsumerWidget {
  const VerificationPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final counter = ref.watch(counterClockProvider(120));

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 20.h),
        width: 366.w,
        decoration: BoxDecoration(
          color: const Color(0x80FFFFFF),
          border: Border.all(
            color: const Color(0x80FFFFFF),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(27),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 20.h),
            child: Column(
              children: [
                const PinInput(
                  control: 'verification',
                  length: 6,
                ),
                SizedBox(height: 10.h),
                ReactiveFormConsumer(builder:
                    (BuildContext context, FormGroup formGroup, Widget? child) {
                  return DynamicButton(
                    height: 40.h,
                    width: 300.w,
                    title: 'Verification'.i18n,
                    onPressed: () {
                      ref.read(authNotifierProvider.notifier).phoneLogin();
                    },
                    isDisabled: formGroup.valid ? false : true,
                    icon:const Icon(Icons.message) /*SvgPicture.asset(Assets.svg.message, height: 12.sp)*/,
                  );
                }),
                SizedBox(height: 10.h),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'You did not receive the verification code'.i18n,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                    const Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                ReactiveFormConsumer(builder: (context, form, child) {
                  return DynamicButton(
                    width: 300.w,
                    type: ButtonTypes.Primary,
                    height: 40.h,
                    isDisabled: counter == 0 ? false : true,
                    onPressed: () async {
                      counter == 0
                          ? ref
                              .read(counterClockProvider(120).notifier)
                              .resend()
                          : null;
                      // await ref.read(authNotifierProvider.notifier).sendOTP();
                    },
                    title: counter != 0
                        ? '${'Resend the code through'.i18n} ${formatedTime(timeInSecond: counter)}'
                        : 'Resend the code'.i18n,
                    icon: counter != 0
                        ? Icon(
                            Icons.restart_alt_outlined,
                            size: 20.w,
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        : null,
                  );
                }),
                SizedBox(height: 13.h),
                DynamicButton(
                    width: 300.w,
                    type: ButtonTypes.Danger,
                    height: 40.h,
                    onPressed: () {
                      ref.watch(authFormProvider).reset();
                      ref
                          .read(authNotifierProvider.notifier)
                          .changePhoneNumber();
                    },
                    title: 'Change phone number'.i18n,
                    icon: const Icon(Icons.message)/*SvgPicture.asset(
                      Assets.svg.message,
                      height: 12.sp,
                    )*/),
              ],
            )));
  }
}

formatedTime({required int timeInSecond}) {
  int sec = timeInSecond % 60;
  int min = (timeInSecond / 60).floor();
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  return "$minute : $second";
}
