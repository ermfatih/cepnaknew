import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class PinkElevatedButton extends StatelessWidget {
  const PinkElevatedButton({super.key, this.text, this.onPressed, this.isMini,});
  final String? text;
  final void Function()? onPressed;
  final bool? isMini;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffF7F2FA),
        fixedSize:isMini==null || isMini==false ? Size(context.myWidth, 45):Size(146, 34),
    ),onPressed: onPressed, child: Text(text ?? '',style: context.myTextTheme.bodyMedium,));
  }
}
