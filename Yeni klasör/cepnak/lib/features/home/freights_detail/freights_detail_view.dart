import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/button/pink_elevated_button.dart';
import 'package:cepnak/features/_components/sized_box/custom_spacer.dart';
import 'package:cepnak/features/home/freights_detail/freights_detail_view_model.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FreightsDetail extends StatelessWidget {
  FreightsDetail({super.key});
  final FreightDetailViewModel _freightDetailViewModel=Get.put(FreightDetailViewModel());
  @override
  Widget build(BuildContext context) {
    _freightDetailViewModel.setContext(context);
    return Scaffold(
      appBar: AppBar(title: Text('Yük Detayları'),),
      body: Padding(
        padding: context.paddingLowAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ödeme alındı,\nTeşekkür ederiz.',style: context.myTextTheme.headlineLarge),
            const CustomSpacer(size: 0.01),
            Text('Müşteri bilgilerini aşağıdan takip ediniz',style: context.myTextTheme.headlineSmall),
            const CustomSpacer(size: 0.02),
            SizedBox(width:1.sw,height:190.h,child: GoogleMap(mapType: MapType.normal,initialCameraPosition: CameraPosition(target: LatLng(1289,54809)))),
            Center(child: PinkElevatedButton(text: 'Haritada Göster',isMini: true,onPressed: () {},)),
            const CustomSpacer(size: 0.01),
            Divider(),
            PinkElevatedButton(text: 'Acenta Bilgilerini Görüntüle',onPressed:_freightDetailViewModel.showAgentDetailDialogButton),
            const CustomSpacer(size: 0.02),
            const CustomSpacer(size: 0.01),
            PinkElevatedButton(text: 'Gönderen Bilgilerini Görüntüle',onPressed:_freightDetailViewModel.showDestinationButton),
            const CustomSpacer(size: 0.02),
            PinkElevatedButton(text: 'Alıcı Bilgilerini Görüntüle',onPressed:_freightDetailViewModel.showSourceButton),
            const CustomSpacer(size: 0.02),
            Center(child: GreenElevatedButton(onPressed: () {
              NavigatorManager.instance.pushToPage(NavigatesRoutes.freightsStateView);
            },text: 'Yük Durumuna Git',))

          ],
        ),
      ),
    );
  }
}
