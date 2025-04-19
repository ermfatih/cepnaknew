import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/home/freights/freights_view.dart';
import 'package:cepnak/features/home/home/home_view.dart';
import 'package:cepnak/features/home/old_freights/old_freights_view.dart';
import 'package:cepnak/features/home/profile/profile_view.dart';
import 'package:cepnak/features/home/tab/tab_controller.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TabsView extends StatefulWidget {

  TabsView({super.key});

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  final TabViewModel _tabViewModel=Get.put(TabViewModel());

  @override
  void initState() {
    Future.microtask(() {
      final modelId = ModalRoute.of(context)?.settings.arguments;
      if (modelId is int) {
        _tabViewModel.selectedPage.value=modelId;
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> pages=[
      OldFreights(),
      FreightsView(),
      HomeView(),
      ProfileView()
    ];

    return Scaffold(
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        onTap: (value) =>_tabViewModel.changeTab(value),
        currentIndex: _tabViewModel.selectedPage.value,
        items:  [
          BottomNavigationBarItem(icon: Image.asset(PngItems.oldFreights.pngPath,height: 35,),label: 'Eski Yükler'),
          BottomNavigationBarItem(icon: Image.asset(PngItems.freights.pngPath,height: 35,),label: 'Taşıma İlanları'),
          BottomNavigationBarItem(icon: Image.asset(PngItems.home.pngPath,height: 35,),label: 'Anasayfa'),
          BottomNavigationBarItem(icon: Image.asset(PngItems.profile.pngPath,height: 35,),label: 'Profil'),
        ],
      )),
      body:Obx(() => IndexedStack(
        index: _tabViewModel.selectedPage.value,
        children: [
          OldFreights(),
          FreightsView(),
          HomeView(),
          ProfileView()
        ],
      )),
    );
  }
}