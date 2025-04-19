import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation/pages/create_personal_profile.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/verification_page.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';

Widget getStep(
  AuthStatus? status,
) {
  switch (status) {
    case AuthStatus.verfication:
      return const VerificationPage();
    case AuthStatus.authrized:
      return Container();
    case AuthStatus.unAuthrized:
      return const LoginPage();
    case AuthStatus.registration:
      return const CreatePresonalProfile();
    default:
      return Container();
  }
}

class AuthFlowPage extends ConsumerWidget {
  static String get routeName => 'auth';
  static String get routePath => '/auth';
  final String? referralSeventyCode;
  const AuthFlowPage({
    super.key,
    this.referralSeventyCode,
  });

  @override
  Widget build(BuildContext context, ref) {
    final authNotifier = ref.watch(authNotifierProvider);
    return authNotifier.when(
      data: (data) {
        return getStep(
          data.status,
        );
      },
      error: (err, st) {
        return Container();
      },
      loading: () {
        return Container(
          decoration: BoxDecoration(
              /*image: DecorationImage(
                  image: AssetImage(
                    Assets.png.background.path,
                  ),
                  fit: BoxFit.cover)*/),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/cepnak_splash.png'),
              //SvgPicture.asset(Assets.svg.appLogo),
              SizedBox(height: 30.h),
              const CircularProgressIndicator(color: Colors.red,)
            ],
          ),
        );
      },
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
    );
  }
}
