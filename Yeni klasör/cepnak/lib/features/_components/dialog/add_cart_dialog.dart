import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/text_field/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../home/payment/payment_view_model.dart';


class AddCard extends StatefulWidget {
  const AddCard({super.key,});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final PaymentViewModel _paymentControl=Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 300.h,
        child: ReactiveForm(
          formGroup: _paymentControl.formCard,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomReactiveField(label: 'Kart İsmi',formControlName: 'cardHolderName'),
              CustomReactiveField(label: 'Cart Numarası',formControlName: 'cardNumber'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 0.4.sw,child: CustomReactiveField(label: 'Son kullanma Tarihi',formControlName: 'expiryDate'),),
                  SizedBox(width: 0.2.sw,child: CustomReactiveField(label: 'cvv',formControlName: 'cvvCode'),)
                ],),
              GreenElevatedButton(text: 'Kartı Kaydet',onPressed: _paymentControl.onPressedCard,)
            ],
          ),
        ),
      ),
    );
  }
}