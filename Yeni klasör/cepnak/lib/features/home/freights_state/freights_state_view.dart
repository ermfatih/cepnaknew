import 'package:bot_toast/bot_toast.dart';
import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/button/pink_elevated_button.dart';
import 'package:cepnak/features/home/freights/freights_service.dart';
import 'package:cepnak/features/home/freights/freights_view_model.dart';
import 'package:cepnak/features/home/freights_state/freights_state_view_model.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FreightsStateView extends StatefulWidget {
  const FreightsStateView({super.key});

  @override
  State<FreightsStateView> createState() => _FreightsStateViewState();
}

class _FreightsStateViewState extends State<FreightsStateView> {
  final FreightsStateViewModel _stateController=Get.put(FreightsStateViewModel());
  final _freightService=Get.put(FreightService());
  List<String>? gList;
  @override
  void initState() {
    super.initState();
    getBeforeStates();
  }
  void getBeforeStates()async{
    gList=await _stateController.findIndex();
    //gList?.remove(gList?.last);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yük Durumu'),
      leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: () {
        NavigatorManager.instance.pushNamedAndUntil(NavigatesRoutes.tabs,arguments: 2);
      },),
      ),
      body:
      SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: context.paddingLowAll,
          child: Column(
            children: [
              ...List.generate(gList?.length ?? 0, (index) => Container(margin: context.paddingLowVertical,color: Colors.blueGrey[200],height:60,child: Center(child:Text(gList?[index] ?? ''),))),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      _stateController.changeState();
                    });
                  },
                  child: Container(margin: context.paddingLowVertical,color: Colors.blueGrey[200],height:60,
                      child: Center(child:Text('son durum'),))),
              SizedBox(height: 150.h,),
              //PinkElevatedButton(onPressed: () {},text: 'İşi İptal Et',),
              FutureBuilder(future: _freightService.getFreightContinue(),
                builder: (context, snapshot) {
                return GreenElevatedButton(onPressed: () async{
                  BotToast.showLoading();
                  await _freightService.updateFreightsCompleteStateById(snapshot.data?.objectId ?? '');
                  NavigatorManager.instance.pushToPage(NavigatesRoutes.tabs);
                  BotToast.closeAllLoading();
                },text: 'Yükü Teslim Et',);
              },),
            ],),
        ),
      ),
    );
  }
}