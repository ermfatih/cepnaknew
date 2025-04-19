import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/button/pink_elevated_button.dart';
import 'package:cepnak/features/_components/sized_box/custom_spacer.dart';
import 'package:cepnak/features/home/profile/profile_view.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';

class TransactionFinishedView extends StatelessWidget {
  const TransactionFinishedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: context.paddingLowAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tebrikler',style: context.myTextTheme.headlineLarge!.copyWith(color: Color(0xff2AA14A))),
            CustomSpacer(size: 0.01),
            Text('Teslimat Bitti\nÖdemenizi Alabilirsiniz',style: context.myTextTheme.headlineLarge),
            CustomSpacer(size: 0.04),
            //PinkElevatedButton(text: 'Teslim Edilen İşleri Gör',onPressed: () {NavigatorManager.instance.pushReplacement(NavigatesRoutes.tabs,arguments: 0);},),
            //CustomSpacer(size: 0.02),
            //PinkElevatedButton(text: 'Mevcut Araç Durumunu Güncelle',onPressed: () {},),
           // CustomSpacer(size: 0.02),
           // PinkElevatedButton(text: 'Fatura Kes',onPressed: () {},),
            //CustomSpacer(size: 0.02),
           // PinkElevatedButton(text: 'İşi Değerlendir',onPressed: () {},),
            //CustomSpacer(size: 0.02),
            //ProfileTool(text: 'Ara Ver',isOpenButton: true,pngItem: PngItems.bed,),
            //CustomSpacer(size: 0.16),
            //Center(child: GreenElevatedButton(text: 'İşi Tamamla',onPressed: () {},))
          ],
        ),
      ),
    );
  }
}
