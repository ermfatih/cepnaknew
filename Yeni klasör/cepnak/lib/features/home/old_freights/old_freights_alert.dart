import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';

class OldFreightsAlert extends StatelessWidget {const OldFreightsAlert({super.key,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Yük Detayları',style: context.myTextTheme.headlineMedium),
      content:  const SizedBox(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text('ücret:'),
              Text('Komisyon:'),
              Text('Acenta:'),
              Text('Not:'),
              Text('Puan:'),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('21.000 Tl'),
                Text('20000 TL'),
                Text('Fora Taşımacılık'),
                Text('Lastik Patladı'),
                Text('5 yıldız'),
              ],
            )
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