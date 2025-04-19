import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:flutter/material.dart';

class ElevatedButtonIcon extends StatelessWidget {
  const ElevatedButtonIcon({super.key, this.text, this.onPressed, this.isFixedSize,});
  final String? text;
  final void Function()? onPressed;
  final bool? isFixedSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style:  ElevatedButton.styleFrom(
      fixedSize:isFixedSize==true || isFixedSize==null? Size(context.myWidth, context.myHeight/15):Size(context.myWidth*.28, context.myHeight*.05),
      backgroundColor: Color(0xffF0EBEB),
    ),
      onPressed: onPressed, icon: Image.asset(PngItems.down.pngPath,height:context.myHeight/30 ),label: Text(text ?? '',style: context.myTextTheme.headlineSmall),);
  }
}
