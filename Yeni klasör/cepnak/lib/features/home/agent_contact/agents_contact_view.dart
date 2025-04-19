import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/sized_box/custom_spacer.dart';
import 'package:cepnak/features/home/freights/freights_view_model.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgentsContact extends StatefulWidget {
  const AgentsContact({super.key});

  @override
  State<AgentsContact> createState() => _AgentsContactState();
}

class _AgentsContactState extends State<AgentsContact> {
  FreightsViewModel _freightsViewModel=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pazarlık Et'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLowAll,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width:context.myWidth*.2,height: 70,child: CircleAvatar(backgroundImage: AssetImage(PngItems.man.pngPath))),
                  SizedBox(width:context.myWidth*.7,height: 80,child: ListTile(title: Text(_freightsViewModel.agentModel?.phone ?? '',style: context.myTextTheme.headlineMedium,),subtitle: Text(_freightsViewModel.agentModel?.phone ?? '',style: context.myTextTheme.headlineSmall),)),
                ],
              ),
              CustomSpacer(size: 0.01),
              Container(height: context.myHeight*.45,width: context.myWidth,decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(15)
              ),),
              CustomSpacer(size: 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width:context.myWidth*.55,height: 60.h,),
                  CustomSpacer(size: 0.1),
                  SizedBox(child: ElevatedButton(onPressed: () {}, child: Text('Teklif Gönder'))),
                ],
              ),
              //CustomSpacer(size: 0.05),
              GreenElevatedButton(onPressed: () {
                NavigatorManager.instance.pushToPage(NavigatesRoutes.paymentView);
              },text: 'İşi Kabul Et',)
            ],
          ),
        ),
      ),
    );
  }
}

