import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

import '../../application/authtication_provider.dart';
import '../../application/verification_form_provider.dart';
import '../components/verification_page_body.dart';
import '../components/verification_page_info.dart';
import '../widgets/app_logo.dart';

class VerificationPage extends ConsumerWidget {
  const VerificationPage({super.key});
  static String get routeName => "verification";
  static String get routePath => "/$routeName";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authForm = ref.watch(authFormProvider);
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      constraints: const BoxConstraints(),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/cepnak_splash.png'),
        fit: BoxFit.cover,
      )),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 33.h),
                const AppLogo(),
                SizedBox(height: 33.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.h),
                  child: VerificationPageInfo(
                    phoneNumber:
                        (authForm.control("phone") as FormControl<PhoneNumber>)
                                .value
                                ?.international ??
                            "",
                  ),
                ),
                SizedBox(height: 10.h),
                ReactiveForm(
                    formGroup: ref.watch(verificationFormProvider),
                    child: const VerificationPageBody()),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
