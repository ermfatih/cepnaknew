import 'package:cepnak_agency/authentication/provider/auth_notifier.dart';
import 'package:cepnak_agency/core/presentation/widget/dynamic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:i18n_extension/default.i18n.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../application/register_form_provider.dart';
import '../components/personal_profile_body.dart';

class CreatePresonalProfile extends ConsumerWidget {
  const CreatePresonalProfile({
    super.key,
  });
  static String get routeName => "personal-profile";
  static String get routePath => "/$routeName";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        constraints: const BoxConstraints(),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/cepnak_splash.png'),
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.symmetric(horizontal: 50.h),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DynamicButton(onPressed: (){
                  ref.read(authNotifierProvider.notifier).changePhoneNumber();
                }),
                Text(
                  "Create Account".i18n,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                    width: 400.w,
                    child: ReactiveForm(
                      formGroup: ref.watch(registerFormProvider),
                      child: const CreatePersonalProfileBody(),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
