import 'package:cepnak_agency/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../router.dart';
import '../../../authentication/provider/auth_notifier.dart';
import '../../../theme.dart';
import '../../domain/navigation_item.dart';

class AppBarTitleState {
  final String? name;
  final String? url;

  AppBarTitleState(this.name, this.url);
}

final appBarTitleProvider =
    StateProvider.autoDispose<AppBarTitleState?>((ref) => null);

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({
    super.key,
    required this.canPop,
  });
  final bool canPop;
  @override
  Widget build(BuildContext context, ref) {
    final colors = ref.read(appColorLightProvider);
    final index = ref.watch(activeButtonIndexProvider);
    final title = ref.watch(appBarTitleProvider)?.name;
    final url = ref.watch(appBarTitleProvider)?.url;
    final user = ref.watch(authNotifierProvider).value?.agent;
    final router = ref.watch(routeProvider);
    final textTheme=Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(

        color: const Color(0xffD9D9D9),
        borderRadius: BorderRadius.all(Radius.circular(8.r))
      ),
      margin: EdgeInsetsDirectional.only(bottom: 3.h,start: 10.w, end: 10.w),
      height: 60.h,
      width: 1.sw,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          canPop?IconButton(
            icon: Icon(Icons.arrow_back_ios, color: colors.whiteish),
            onPressed: () {
              //ref.read(authNotifierProvider.notifier).logout();
              //ref.read(appBarTitleProvider.notifier).state = null;
              context.pop();
            },
          ):SizedBox(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(bottonNavigationList[index].screenTitle,style: textTheme.headlineSmall?.copyWith(
                  fontSize: 17.sp,
                  color: colors.orangish,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  shadows: [Shadow(color: colors.blackish,blurRadius: 5)]
              )),
              Image.asset(bottonNavigationList[index].screenIcon,height: 30.h,),
            ],
          ),
          Container(
            margin: EdgeInsetsDirectional.only(end: 10.w),
            child: Assets.png.transit.image(),/*Transform.scale(
                scale: 1.h,
                child: Assets.png.logoAppBar.image(height: 41.h),
                  )*/
          ),
        ],
      ),
    );
  }
  Text buildText(BuildContext context, AppColor color, String text) => Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: color.whiteish,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp),
      );
}
