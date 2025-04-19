import 'package:bot_toast/bot_toast.dart';
import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/core/extensions/string_extensions.dart';
import 'package:cepnak/features/_components/future_builder_items/custom_future_builder.dart';
import 'package:cepnak/features/home/freights/freights_view_model.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:cepnak/product/models/agent_model.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../product/i18n/strings.g.dart';
import 'freights_service.dart';

class FreightsView extends StatefulWidget {
  const FreightsView({super.key});

  @override
  State<FreightsView> createState() => _FreightsViewState();
}

class _FreightsViewState extends State<FreightsView> {
  final FreightsViewModel _viewModel=Get.put(FreightsViewModel());
  final FreightService _service=FreightService();
  Agent? _agentModel;
  @override
  void initState() {
    super.initState();
    //FreightService().addRelationalFreights();
    //FreightService().addRelationsAgent();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(freightPosting.i18n),actions: [
        /*Padding(
          padding: EdgeInsets.all(6.h),
          child: InkWell(onTap: () {
            NavigatorManager.instance.pushToPage(NavigatesRoutes.freightsFilterView);
          },child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(PngItems.filter.pngPath,height: 20.h),
              Text(freightSelection.i18n,style: context.myTextTheme.bodySmall?.copyWith(fontSize: 9.sp,fontWeight: FontWeight.bold,color: Colors.black),)
            ],
          )),
        )*/
      ]),
      body:
      RefreshIndicator(
        onRefresh: ()async{
          _viewModel.getFreights();
        },
        child: FutureBuilder(
          future: _viewModel.getFreights(),
          builder: (context, freights) {
            return ListView.builder(
              itemCount: freights.data?.length ?? 0,
              itemBuilder: (context, index) {
                final agent=freights.data?[index].agentId;
                return Padding(
                  padding: context.paddingLowHorizontal,
                  child: FreightPosting(
                    phoneNumber: agent?.phone,
                    agentName: agent?.name,
                    deliveryDate: freights.data?[index].deliveryDate,
                    price: freights.data?[index].price.toString(),
                    sourceName: freights.data?[index].source?.address?.city,
                    destinationName: freights.data?[index].destination?.address?.city,
                    onTap: () async{
                      final carrier=await _service.getCurrentCarrier();
                      bool value=await _service.checkUserPermission(carrierId: carrier?.objectId ??'', agentId: freights.data?[index].agentId.objectId ??'');
                      if(value){
                        _viewModel.freightModel=freights.data?[index];
                        _viewModel.agentModel=agent;
                        NavigatorManager.instance.pushToPage(NavigatesRoutes.loadDetailView);
                      }else{
                        BotToast.showText(text: 'Acenta izniniz yok lütfen acenta ile iletişime geçiniz');
                      }
                    },
                  ),
                );
              },);
          },
        ),
      ),
    );
  }
}
class FreightPosting extends StatelessWidget {
  const FreightPosting({super.key, this.phoneNumber,this.onTap, this.agentName, this.deliveryDate, this.price, this.sourceName, this.destinationName,});
  final void Function()? onTap;
  final String? agentName;
  final DateTime? deliveryDate;
  final String? price;
  final String? sourceName;
  final String? destinationName;
  final String? phoneNumber;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap:onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h,top: 10.h),
        padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 20.w),
        width: 1.sw,
        decoration: BoxDecoration(color: Colors.white, boxShadow: const [BoxShadow(blurRadius: 4,offset: Offset(0,1),color: Color(0xff000000))],
        border: Border.all(width: 1.w,color: Color(0xffC4C4C4)),
        borderRadius: BorderRadius.circular(20.r)
      ),child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(agentName ?? '',style: context.myTextTheme.headlineSmall),
          SizedBox(height: 5.h),
          Text(phoneNumber ?? '',style: context.myTextTheme.bodyLarge),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateFormat(deliveryDate),style: context.myTextTheme.headlineSmall),
              Text(price ?? '',style: context.myTextTheme.headlineSmall!.copyWith(color: Colors.green))
            ],
          ),
          SizedBox(height: 10.h,),
          IconWithText(iconPath: PngItems.round.pngPath,locationName: sourceName ?? ''),
          const Icon(Icons.arrow_drop_down_outlined),
          IconWithText(iconPath: PngItems.locations.pngPath,locationName: destinationName ?? ''),
        ],
      ),
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  const IconWithText({super.key, required this.iconPath, required this.locationName,});
  final String iconPath;
  final String locationName;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 25.h,width: 22.w,child: Image.asset(iconPath)),
        SizedBox(width: 10.w,),
        Text(locationName),
      ],
    );
  }
}
/*C*/
