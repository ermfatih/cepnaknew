import 'package:cepnak_agency/freights_management/presentation/page/create_field_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../router.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_bottom_app_bar.dart';

class NavigationState extends StateNotifier<int> {
  NavigationState() : super(0);

  void updateScreen(int index) {
    state = index;
  }
}

final navigationProvider = StateNotifierProvider((ref) => NavigationState());

class MainApp extends ConsumerWidget {
  const MainApp({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routeProvider);
     bool canPop = router.location.contains(CreateFreightFormField.routeLocation) ;
    //     router.location.contains(ChatListPage.routePath + ChatPage.routePath) ||
    //     router.location.contains(ApplicationDetailsPage.routePath) ||
    //     router.location.contains(UserPresonalProfile.routePath) ||
    //     router.location.contains(FundingApplicationPage.routePath) ||
    //     router.location.contains(CampaignApplicationPage.routePath);

    return Scaffold(
        extendBody: true,
        bottomNavigationBar:
              canPop ? null :
        const CustomBottomAppBar(),
        body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  SizedBox(height: 35.h),
                  CustomAppBar(canPop: canPop),
                  Expanded(
                    child: child,
                  ),
                ],
              ),
            )

            //  Stack(
            //   fit: StackFit.expand,
            //   children: [
            //     Image.asset(
            //       Assets.png.background.path,
            //       colorBlendMode: BlendMode.color,
            //       fit: BoxFit.fill,
            //     ),
            //
            //   ],
            // ),
            ));
  }
}
