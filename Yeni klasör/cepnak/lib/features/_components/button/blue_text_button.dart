import 'package:flutter/material.dart';

class BlueTextButton extends StatelessWidget {
  const BlueTextButton({super.key, required this.text, this.onPressed,});
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}