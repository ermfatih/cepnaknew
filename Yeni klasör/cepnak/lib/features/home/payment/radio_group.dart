import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'payment_view_model.dart';

class NewWidget extends StatelessWidget {
  NewWidget({
    super.key,
  });

  final PaymentViewModel _paymentControl=Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        RadioListTile(
          title: Text('Kredi Kartı'),
          value: 1, groupValue:_paymentControl.selectedValue.value , onChanged: (value) {
          _paymentControl.selectedValue.value=value!;
        },),
        RadioListTile(
          title: Text('Nakit Ödeme'),
          value: 2, groupValue:_paymentControl.selectedValue.value , onChanged: (value) {
          _paymentControl.selectedValue.value=value!;
        },)
      ],
    ));
  }
}
