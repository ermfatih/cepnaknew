import 'package:cepnak_agency/carriers_management/presentation/page/carriers_page.dart';
import 'package:cepnak_agency/freights_management/presentation/page/freights_page.dart';
import 'package:cepnak_agency/user_management/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/default.i18n.dart';

import '../../gen/assets.gen.dart';
import '../../home/presentation/home_page.dart';


final activeButtonIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

class NavigatorItem {
  final IconData iconName;
  final String description;
  final String initialLocation;
  final String screenTitle;
  final String screenIcon;

  NavigatorItem({
    required this.iconName,
    required this.description,
    required this.initialLocation,
    required this.screenTitle,
    required this.screenIcon,
  });
}

List<NavigatorItem> bottonNavigationList = [
  NavigatorItem(
      iconName:Icons.home_filled,//Assets.svg.messages
      description: "Ana Sayfa".i18n,
      initialLocation: HomePage.routePath,
      screenTitle: "ANA SAYFA".i18n,
      screenIcon: Assets.png.bighome.path
  ),
  NavigatorItem(
      iconName: Icons.business,
      description: "İşler".i18n,
      initialLocation: FreightsPage.routePath,
      screenTitle: "İŞLER".i18n,
      screenIcon: Assets.png.empty.path,
  ),
  NavigatorItem(
      iconName: Icons.fire_truck,//Assets.svg.messages
      description: "Şoförler".i18n,
      initialLocation: CarriersPage.routeLocation,
      screenTitle: "ŞOFÖRLER".i18n,
      screenIcon: Assets.png.bigdriver.path
  ),
  NavigatorItem(
      iconName: Icons.person,
      description: "Profil".i18n,
      initialLocation: ProfilePage.routePath,
      screenTitle: "PROFİL".i18n,
      screenIcon: Assets.png.personbig.path
  )
];
