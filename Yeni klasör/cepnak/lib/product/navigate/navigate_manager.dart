import 'package:cepnak/features/auth/onboard/onboard_view.dart';
import 'package:cepnak/features/auth/register/register_view.dart';
import 'package:cepnak/features/auth/splash/splash_view.dart';
import 'package:cepnak/features/home/agent_contact/agents_contact_view.dart';
import 'package:cepnak/features/home/car/car_add/car_add_view.dart';
import 'package:cepnak/features/home/car/car_update/car_update_view.dart';
import 'package:cepnak/features/home/car/car_view/car_view.dart';
import 'package:cepnak/features/home/freights_detail/freights_detail_view.dart';
import 'package:cepnak/features/home/freights_filter/freights_filter_view.dart';
import 'package:cepnak/features/home/freights_state/freights_state_view.dart';
import 'package:cepnak/features/home/google_map/load_info_map_view.dart';
import 'package:cepnak/features/home/load_info/load_detail_view.dart';
import 'package:cepnak/features/home/payment/payment_view.dart';
import 'package:cepnak/features/home/request/request_view.dart';
import 'package:cepnak/features/home/request/sending_request_view.dart';
import 'package:cepnak/features/home/tab/tabs_view.dart';
import 'package:cepnak/features/home/transaction_finished/transaction_finished_view.dart';
import 'package:flutter/material.dart';
import '../../features/auth/login/login_view.dart';

class NavigatorManager{
  NavigatorManager._();
  static NavigatorManager instance=NavigatorManager._();
  final GlobalKey<NavigatorState> _navigatorGlobalKey=GlobalKey();
  GlobalKey<NavigatorState> get navigatorGlobalKey=>_navigatorGlobalKey;

  void pop() async {
    _navigatorGlobalKey.currentState?.pop();
  }
  Future<void> pushToPage(NavigatesRoutes routes,{Object? arguments}) async {
    await _navigatorGlobalKey.currentState?.pushNamed(routes.withSlash,arguments: arguments);
  }
  Future<void>pushReplacement(NavigatesRoutes routes,{Object? arguments})async{
    await _navigatorGlobalKey.currentState?.pushReplacementNamed(routes.withSlash,arguments: arguments);
  }
  Future<void>pushNamedAndUntil(NavigatesRoutes routes,{Object? arguments})async{
    await _navigatorGlobalKey.currentState?.pushNamedAndRemoveUntil(routes.withSlash,(route) => false,arguments: arguments);
  }
}
class NavigatorRoutes{
  final items={
    NavigatesRoutes.splash.withSlash:(context) =>  SplashView(),
    NavigatesRoutes.register.withSlash:(context) =>  RegisterView(),
    NavigatesRoutes.login.withSlash:(context) =>  LoginView(),
    NavigatesRoutes.request.withSlash:(context) =>  RequestView(),
    NavigatesRoutes.onBoard.withSlash:(context) =>  OnBoardView(),
    NavigatesRoutes.tabs.withSlash:(context) =>  TabsView(),
    NavigatesRoutes.carUpdate.withSlash:(context) => CarUpdateView(),
    NavigatesRoutes.carAddView.withSlash:(context) => CarAddView(),
    NavigatesRoutes.carView.withSlash:(context) => CarView(),
    NavigatesRoutes.loadDetailView.withSlash:(context) => LoadDetailView(),
    NavigatesRoutes.freightsDetail.withSlash:(context) => FreightsDetail(),
    NavigatesRoutes.paymentView.withSlash:(context) => PaymentView(),
    //NavigatesRoutes.agentsContact.withSlash:(context) => AgentsContact(),
    NavigatesRoutes.freightsStateView.withSlash:(context) => FreightsStateView(),
    NavigatesRoutes.transactionFinishedView.withSlash:(context) => TransactionFinishedView(),
    //NavigatesRoutes.freightsFilterView.withSlash:(context) => FreightsFilterView(),
    NavigatesRoutes.sendingRequestView.withSlash:(context) => SendingRequestView(),
    NavigatesRoutes.loadInfoMapView.withSlash:(context) => LoadInfoMapView(),
  };
}
enum NavigatesRoutes{
  splash,register,login,request,home,detail,onBoard,tabs,carUpdate,
  carAddView,carView,freightsDetail,loadDetailView,paymentView,
  freightsStateView,transactionFinishedView,sendingRequestView,loadInfoMapView
}
extension NavigateRoutesExtension on NavigatesRoutes{
  String get withSlash => "/$name";
}