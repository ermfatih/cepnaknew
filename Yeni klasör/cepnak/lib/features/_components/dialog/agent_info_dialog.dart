import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/dialog/agents_info_alert.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AgentInfoDialog extends StatelessWidget {
  const AgentInfoDialog({super.key, this.name, this.phone,});
  final String? name;
  final String? phone;
  @override
  Widget build(BuildContext context) {
    return
      AlertDialog(
        title: Text('Acenta Bilgileri'),
        content: SizedBox(
          height: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AlertRow(text:name,),
              AlertRow(text: phone),
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