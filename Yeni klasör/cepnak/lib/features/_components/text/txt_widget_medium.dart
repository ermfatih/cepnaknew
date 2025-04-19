import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class TxtWidgetMedium extends StatelessWidget {
  const TxtWidgetMedium({super.key, required this.text,});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: context.myTheme.textTheme.headlineMedium);
  }
}
