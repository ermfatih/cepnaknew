import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/dialog/agents_info_alert.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';


class ReceiverInfoAlert extends StatelessWidget {
  const ReceiverInfoAlert({super.key, this.name, this.phone, this.address,});
  final String? name;
  final String? phone;
  final String? address;
  @override
  Widget build(BuildContext context) {
    return
      AlertDialog(
        title: Text('Alıcı Bilgileri'),
        content: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AlertRow(text:name,),
              AlertRow(text: phone),
              AlertRow(text: address),
            ],
          ),
        ),
        actions: [
          GreenElevatedButton(isFixedSize: true,text: 'Tamam',onPressed: () {
            NavigatorManager.instance.pop();
          },)
        ],
      );
  }
}
