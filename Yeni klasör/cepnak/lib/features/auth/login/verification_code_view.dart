import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/blue_text_button.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/text_field/custom_form_field.dart';
import 'package:cepnak/features/auth/login/verification_view_model.dart';
import 'package:cepnak/product/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';


class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({super.key,});
  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}
class _CustomAlertDialogState extends State<CustomAlertDialog> {
  final _verificationController=Get.put(VerificationViewModel());
  @override
  void initState() {
    super.initState();
    _verificationController.startTimer();
  }
  @override
  void dispose() {
    super.dispose();
    _verificationController.closeTimer();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _verificationController.form,
      child: AlertDialog(
        actionsAlignment: MainAxisAlignment.end,
        titleTextStyle: context.myTextTheme.bodyLarge,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sendCode.i18n,style: context.myTextTheme.headlineSmall),
            SizedBox(height: 10.h),
            Obx(() => _verificationController.remainingTime.value==0 ? BlueTextButton(text: sendAgain.i18n,onPressed: () {
              _verificationController.resetTime();
              _verificationController.startTimer();
            },): Text('${remainingTime.i18n}: ${_verificationController.remainingTime} ${second.i18n}',style: context.myTextTheme.headlineSmall))
             ,
          ],
        ),
        content: CustomReactiveField(formControlName: 'code',label: enterCode.i18n),
        actions: [
          GreenElevatedButton(isFixedSize: false,text: cancel.i18n,onPressed: () {
            Navigator.pop(context);
          },),
          GreenElevatedButton(isFixedSize: false,text: send.i18n,onPressed: () {},),],
      ),
    );
  }
}
