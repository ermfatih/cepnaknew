/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:lottie/lottie.dart';
import 'package:shafak_donor/theme.dart';
import '../../../../../gen/assets.gen.dart';
import 'package:app_settings/app_settings.dart';

import '../widget/dynamic_button.dart';

class NoNetworkPage extends ConsumerWidget {
  const NoNetworkPage({super.key});
  static String get routeName => 'no-network';
  static String get routePath => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Assets.png.background.image().image)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.h, left: 15.w),
                child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Assets.png.logoAppBar.image()),
              ),
              SizedBox(height: 40.h, width: 1.sw),
              SizedBox(
                  width: 0.8.sw,
                  height: 0.6.sh,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: Text(
                          "You don't have internet connection !".i18n,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  color: appColor.whiteish,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Expanded(child: Lottie.asset(Assets.lottie.network)),
                      DynamicButton(
                        title: 'Open Internet'.i18n,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: appColor.whiteish,
                            fontWeight: FontWeight.w500),
                        onPressed: () async {
                          await AppSettings.openAppSettings(
                              type: AppSettingsType.device);
                        },
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
*/