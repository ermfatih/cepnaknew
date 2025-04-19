import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/dialog/agents_info_alert.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SourceInfoAlert extends StatelessWidget {
  const SourceInfoAlert({super.key, this.name, this.phone});
  final String? name;
  final String? phone;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Alıcı Bilgileri'),
      content: SizedBox(
        height: 120.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlertRow(text:name,),
            AlertRow(text: phone),
          ],
        ),
      ),
      actions: [
        GreenElevatedButton(isFixedSize: false,text: 'Tamam',onPressed: () {
          NavigatorManager.instance.pop();
        },)
      ],
    );
  }
}
