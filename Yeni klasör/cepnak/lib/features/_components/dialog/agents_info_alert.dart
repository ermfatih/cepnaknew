
import 'package:flutter/material.dart';

class AlertRow extends StatelessWidget {
  const AlertRow({super.key, this.text,});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.man),
        Text(text ?? '')
      ],
    );
  }
}
