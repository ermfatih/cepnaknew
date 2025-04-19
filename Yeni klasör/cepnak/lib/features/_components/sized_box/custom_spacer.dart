import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({super.key, this.repeat, required this.size});
  final double? repeat;
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height:repeat==null ? context.myHeight*size: context.myHeight*size*repeat!,);
  }
}
