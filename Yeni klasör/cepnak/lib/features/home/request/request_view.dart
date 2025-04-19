import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/button/pink_elevated_button.dart';
import 'package:cepnak/features/_components/text_field/custom_form_field.dart';
import 'package:cepnak/features/_components/text_field/reactive_field_collapsed.dart';
import 'package:cepnak/features/home/request/request_view_model.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:cepnak/product/i18n/strings.g.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RequestView extends StatelessWidget {
  RequestView({super.key});
  RequestViewModel _requestViewModel=Get.put(RequestViewModel());
  @override
  Widget build(BuildContext context) {
    _requestViewModel.setContext(context);
    return Scaffold(
      appBar: AppBar(title: Text(sendRequest.i18n)),
      body: Padding(
        padding: context.paddingLowAll,
        child: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: _requestViewModel.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(agentRequest.i18n,style: context.myTextTheme.headlineMedium,),
                SizedBox(height: 15.h,),
                CustomReactiveField(formControlName: 'phone',label: phoneNumber.i18n,textInputType: TextInputType.number,),
                ReactiveFieldCollapsed(formControlName: 'message',hintText: 'Bu Alana Mesajınızı Giriniz'),
                SizedBox(height: 15.h,),
                Align(child: GreenElevatedButton(isFixedSize: true,text: 'Gönder',onPressed: _requestViewModel.sendRequest),alignment: Alignment.bottomCenter),
                SizedBox(height: 220.h,),
                PinkElevatedButton(text: 'Gönderilen Talepleri Görüntüle',onPressed: () {
                  NavigatorManager.instance.pushToPage(NavigatesRoutes.sendingRequestView);},),
                SizedBox(height: 15.h,),
                Center(child: GreenElevatedButton(text: buttonGoHome.i18n,onPressed: () {
                  NavigatorManager.instance.pushNamedAndUntil(NavigatesRoutes.tabs,arguments: 2);
                },))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class SendButton extends StatelessWidget {
  const SendButton({super.key, this.onTap,});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,child: Image.asset(PngItems.send.pngPath));
  }
}

