import 'package:bot_toast/bot_toast.dart';
import 'package:cepnak_agency/carriers_management/presentation/page/carriers_page.dart';
import 'package:cepnak_agency/freights_management/presentation/page/create_field_form_page.dart';
import 'package:cepnak_agency/freights_management/presentation/page/freights_page.dart';
import 'package:cepnak_agency/splash_page.dart';
import 'package:cepnak_agency/home/presentation/home_page.dart';
import 'package:cepnak_agency/user_management/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/widgets.dart';

import 'authentication/provider/auth_flow_page.dart';
import 'authentication/provider/auth_notifier.dart';
import 'authentication/provider/auth_state.dart';
import 'core/presentation/page/main_app.dart';

final subTitleProvider = StateProvider<String?>((ref) => null);

final _key = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routeProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authNotifierProvider);

  return GoRouter(
      observers: [BotToastNavigatorObserver()],
      navigatorKey: _key,
      debugLogDiagnostics: true,
      initialLocation: AuthFlowPage.routePath,
      routes: [
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return MainApp(child: child);
            },
            routes: [//
              GoRoute(
                path: HomePage.routePath,
                name: HomePage.routeName,
                builder: (context, state) => const HomePage(),
              ),
              GoRoute(//
                path: ProfilePage.routePath,
                name: ProfilePage.routeName,
                builder: (context, state) => const ProfilePage(),
              ),
              GoRoute(
                path: FreightsPage.routePath,
                name: FreightsPage.routeName,
                builder: (context, state) => const FreightsPage(),
                routes: [
                  GoRoute(
                    path: CreateFreightFormField.routeLocation,
                    name: CreateFreightFormField.routeName,
                    builder: (context, state) => const CreateFreightFormField(),
                  ),
                ]
              ),
              GoRoute(
                path: CarriersPage.routeLocation,
                name: CarriersPage.routeName,
                builder: (context, state) => const CarriersPage(),
              ),
              /*GoRoute(
                path: NotificationsPage.routePath,
                name: NotificationsPage.routeName,
                builder: (context, state) => const NotificationsPage(),
              ),*/
            ]),

        GoRoute(
          path: AuthFlowPage.routePath,
          name: AuthFlowPage.routeName,
          builder: (context, state) => const AuthFlowPage(),
        ),

      ],
      redirect: (context, state) async {
        // final onBoardValue=await SharedPreferenceLanguage.checkOnboardValue();
        return authNotifier.when(
          data: (data) {
            //final isNoInternet = ref.watch(connectivityStateProvider).value;
            // final Uri? uri = Uri.tryParse(Uri.base.toString());
            final isAuth = data.status == AuthStatus.authrized;
            //final isSplash = state.location == OnBoardPage.routePath;
            final isLoggingIn = state.location == AuthFlowPage.routePath;

            /* if(onBoardValue!=true){
              return OnBoardPage.routePath;
            } */

            if (isLoggingIn) {
              //return isAuth ? HomePage.routePath : null;
              return isAuth ? HomePage.routePath : AuthFlowPage.routePath;
            }
            return isAuth ? state.location : AuthFlowPage.routePath;
          },
          error: (error, stak) {
            return null;
          },
          loading: () => null,
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
        );
      });
});
