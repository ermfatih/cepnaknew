import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/presentation/widget/dynamic_button.dart';
import '../../../core/presentation/widget/dynamic_input.dart';
import '../../../theme.dart';
import '../../application/authtication_provider.dart';
import '../../provider/auth_notifier.dart';
import '../widgets/app_logo.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({
    super.key,
  });
  static String get routeName => "login";
  static String get routePath => "/$routeName";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorProvider = ref.read(appColorLightProvider);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            decoration: const BoxDecoration(
                /*image: DecorationImage(
              image: AssetImage('assets/cepnak_splash.png'),//Assets.png.loginBacground.path
              fit: BoxFit.cover,
            )*/),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: AppLogo()),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 30),
                      child: Text(
                        "Welcome To".i18n,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 27.sp),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 45),
                      child: Text(
                        "Cepnak Agency".i18n,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 27.sp,
                            color: colorProvider.orangish),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Center(
                      child: ReactiveForm(
                        formGroup: ref.watch(authFormProvider),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: 366.w,
                          decoration: BoxDecoration(
                            color: const Color(0x80FFFFFF),
                            border: Border.all(
                              color: const Color(0x80FFFFFF),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(27),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DynamicInput(
                                control: 'phone',
                                type: Type.phoneNumber,
                                title: 'Phone number'.i18n,
                                placeholder: '550 000 00 00',
                                width: 300.w,
                                height: 40.h,
                              ),
                              SizedBox(height: 12.h),
                              SizedBox(
                                  width: 300.w,
                                  child: Text(
                                    'Send verification code by:'.i18n,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 12.sp),
                                  )),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(child: ReactiveFormConsumer(
                                      builder: (context, form, widget) {
                                    return DynamicButton(
                                      height: 40.h,
                                      onPressed: () async {
                                        await ref
                                            .read(authNotifierProvider.notifier)
                                            .sendOTP();
                                      },
                                      type: ButtonTypes.Secondary,
                                      title: "SMS".i18n,
                                      isDisabled: form.invalid,
                                      icon:const Icon(Icons.message) /*SvgPicture.asset(
                                        Assets.svg.message,
                                        width: 12.w,
                                        height: 12.h,
                                      ),*/
                                    );
                                  })),
                                  SizedBox(width: 8.w),
                                  Expanded(child: ReactiveFormConsumer(
                                      builder: (context, form, widget) {
                                    return DynamicButton(
                                      type: ButtonTypes.Success,
                                      height: 40.h,
                                      onPressed: () async {
                                        // await ref
                                        //     .read(authNotifierProvider.notifier)
                                        //     .sendWhatsAppOTP();
                                      },
                                      title: 'WhatsApp'.i18n,
                                      // isDisabled: form.invalid,
                                      icon: const Icon(Icons.facebook),
                                    );
                                  })),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  Center(
                                    child: DynamicButton(
                                      width: 300.w,
                                      type: ButtonTypes.Primary,
                                      height: 40.h,
                                      onPressed: () {
                                        // ref
                                        //     .read(authNotifierProvider.notifier)
                                        //     .handleSignIn();
                                      },
                                      title: 'Sign in with Google'.i18n,
                                      icon: const Icon(Icons.search),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  Center(
                                    child: DynamicButton(
                                      width: 300.w,
                                      type: ButtonTypes.Primary,
                                      height: 40.h,
                                      onPressed: () {
                                        // ref
                                        //     .read(authNotifierProvider.notifier)
                                        //     .handleSignIn();
                                      },
                                      title: 'Sign in with Facebook'.i18n,
                                      icon: Icon(Icons.facebook),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  Center(
                                    child: DynamicButton(
                                      width: 300.w,
                                      type: ButtonTypes.Alternative,
                                      height: 40.h,
                                      onPressed: () {
                                        // ref
                                        //     .read(authNotifierProvider.notifier)
                                        //     .handleSignIn();
                                      },
                                      title: 'Sign in with Apple'.i18n,
                                      icon: const Icon(Icons.apple),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: DynamicButton(
                                  title: 'Create Account',
                                    onPressed: (){
                                    ref.read(authNotifierProvider.notifier).changeRegistrationState();
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
