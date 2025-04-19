import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/button/pink_elevated_button.dart';
import 'package:cepnak/features/_components/dialog/add_cart_dialog.dart';
import 'package:cepnak/features/home/freights/freights_view_model.dart';
import 'package:cepnak/features/home/payment/payment_view_model.dart';
import 'package:cepnak/features/home/payment/radio_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PaymentView extends StatelessWidget {
  PaymentView({super.key});

  final PaymentViewModel _paymentControl=Get.put(PaymentViewModel());
  final FreightsViewModel _freightsViewModel=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ödeme Ekranı'),),
      body: Padding(
        padding: context.paddingLowAll,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lütfen Bir Ödeme Yöntemi Seçiniz',style: context.myTextTheme.headlineMedium,),
              buildSizedBox(),
              Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.red
              ),child: NewWidget(),
              ),
              buildSizedBox(),
              Obx(() => _paymentControl.selectedValue.value!=2 ? Text('Lütfen Bir Kart Seçiniz',style: context.myTextTheme.headlineMedium):SizedBox.shrink(),),
              buildSizedBox(),
              Obx(() => _paymentControl.selectedValue.value!=2 ? CreditCard():SizedBox.shrink(),),
              Obx(() =>_paymentControl.selectedValue.value!=2 ? Center(child: PinkElevatedButton(isMini: true,text: 'Kart Ekle',onPressed: () {
                showDialog(context: context, builder: (context) {
                  return AddCard();
                },);
              },)):SizedBox.shrink(),),
              buildSizedBox(),
              Divider(),
              buildSizedBox(),
              Obx(() => _paymentControl.isSelected.value==false ? Text('Komisyon Tutarı: ${_freightsViewModel.freightModel?.commission.toString()} TL',style: context.myTextTheme.headlineMedium):SizedBox.shrink(),),
              buildSizedBox(),
              Center(child: GreenElevatedButton(onPressed: _paymentControl.onPressedApprove,text: 'Tutarı onayla'))

            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBox() => SizedBox(height: 15.h,);
}
class CreditCard extends StatefulWidget { CreditCard({super.key,});
  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
final PaymentViewModel _paymentControl=Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: FutureBuilder(
        future: _paymentControl.getCards(),
        builder: (context, snapshot) {
          return PageView.builder(
            controller: PageController(viewportFraction: 0.9),
            itemCount: snapshot.data?.length ?? 0 ,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CreditCardWidget(
                isHolderNameVisible: true,
                isSwipeGestureEnabled: false,
                padding: 2,
                cardNumber: snapshot.data?[index].cardNumber ?? '', expiryDate: snapshot.data?[index].expiryDate ?? '', cardHolderName: snapshot.data?[index].cardHolderName ?? '', cvvCode: snapshot.data?[index].cvvCode ?? '', showBackView: false, onCreditCardWidgetChange: (p0) {},);
            },
          );
        },
      ),
    );
  }
}
