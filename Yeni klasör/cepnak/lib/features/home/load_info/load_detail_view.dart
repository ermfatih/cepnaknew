import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/button/pink_elevated_button.dart';
import 'package:cepnak/features/_components/dialog/agent_info_dialog.dart';
import 'package:cepnak/features/_components/sized_box/custom_spacer.dart';
import 'package:cepnak/features/home/freights/freights_model.dart';
import 'package:cepnak/features/home/freights/freights_view_model.dart';
import 'package:cepnak/features/home/load_info/load_info_view_model.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoadDetailView extends StatefulWidget {
  const LoadDetailView({super.key});

  @override
  State<LoadDetailView> createState() => _LoadDetailViewState();
}

class _LoadDetailViewState extends State<LoadDetailView> {
  LoadInfoViewModel _model=Get.put(LoadInfoViewModel());
  FreightsViewModel _freightsViewModel=Get.find();
  Freight? _freightsModel;
  late Duration date;
  late DateTime deliveryDate;
  late int day;
  void takeFreightsModelFromController(){
    _freightsModel=_freightsViewModel.freightModel;
  }
  void fun(){
    deliveryDate = _freightsModel!.deliveryDate!;
    date = deliveryDate.difference(DateTime.now());
    day = date.inDays;
  }
  @override
  void initState() {
    takeFreightsModelFromController();
    fun();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yük Bilgi'),),
      body: Padding(
        padding: context.paddingLowAll,
        child: Builder(
          builder: (context,) {

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RowWidget(pngItems: PngItems.trucks,
                    text: _freightsModel?.cargoType ?? '',
                    response: _freightsModel?.price.toString() ?? '',
                    isMini: false),
                const Divider(),
                Location(pngItems: PngItems.round,
                  text: (_freightsModel?.source?.address?.country ?? '') + ', ' +
                      (_freightsModel?.source?.address?.city ?? '')+(_freightsModel?.source?.address?.district ?? '') + ', '
                      +(_freightsModel?.source?.address?.description ?? ''),
                  subText: '' + '' ,),
                customDivider(),
                Location(pngItems: PngItems.round,
                  text: (_freightsModel?.destination?.address?.country ?? '') + ', ' +
                      (_freightsModel?.destination?.address?.city ?? '')+(_freightsModel?.destination?.address?.district ?? '') + ', '
                      +(_freightsModel?.destination?.address?.description ?? ''),
                  subText: '' + '' ,),
                PinkElevatedButton(
                    isMini: true, onPressed: _model.showMapButton, text: 'Haritada Göster'),
                const Divider(),
                RowWidget(pngItems: PngItems.walk,
                    text: 'Mesafe',
                    response: (_freightsModel?.distance.toString() ?? '') +
                        ' km'),
                const Divider(),
                RowWidget(pngItems: PngItems.tonnage,
                    text: 'Ağırlık',
                    response: (_freightsModel?.weight.toString() ?? '') +
                        ' Ton'),
                const Divider(),
                RowWidget(pngItems: PngItems.time,
                    text: 'Zaman',
                    response: day.toString() + ' Gün'),
                const Divider(),
                RowWidget(pngItems: PngItems.commission,
                    text: 'Komisyon Tutarı',
                    response: (_freightsModel?.commission.toString() ?? '') +
                        ' TL',
                    isMini: false),
                const Divider(),
                const RowWidget(pngItems: PngItems.expensive,
                    text: 'Yaklaşık Maliyet',
                    response: '4000 TL',
                    isMini: false),
                const Divider(),
                const CustomSpacer(size: 0.01),
                PinkElevatedButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) {
                        return AgentInfoDialog(phone: _freightsViewModel.agentModel?.phone,name: _freightsViewModel.agentModel?.name,);
                      },);
                    }, text: 'Acenta Bilgilerini Görüntüle'),
                const CustomSpacer(size: 0.01),
                Center(child: GreenElevatedButton(
                  onPressed: () {
                    NavigatorManager.instance.pushToPage(NavigatesRoutes.paymentView);
                  }, text: 'İşi Kabul Et',))
              ],
            );
          }
        ),
      ),
    );
  }

  Padding customDivider() {
    return Padding(padding:EdgeInsets.symmetric(vertical: 10.h), child: Container(height: 42.h,width: 2.w,color: Colors.black),);
  }
}

class Location extends StatelessWidget {
  const Location({super.key, required this.pngItems, required this.text, required this.subText,});
  final PngItems pngItems;
  final String text;
  final String subText;
  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Image.asset(pngItems.pngPath,height: 30.h,),title: Text(text,style: context.myTextTheme.headlineSmall),subtitle: Text(subText,style: context.myTextTheme.bodyMedium),);
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({super.key, required this.pngItems, required this.text, required this.response, this.isMini=true,});
  final PngItems pngItems;
  final String text;
  final String response;
  final bool isMini;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Image.asset(pngItems.pngPath,height:isMini ?  context.lowValue:context.lowValue*2, width:isMini ? context.lowValue:context.lowValue*2,),
        SizedBox(width:isMini? 26.w:10.w,),
        Text(text,style:isMini ? context.myTextTheme.bodyMedium:context.myTextTheme.headlineMedium,)
      ],),
      Text(response,style: context.myTextTheme.headlineSmall),
    ]);
  }
}
