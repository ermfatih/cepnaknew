
import 'package:flutter/material.dart';

class CustomShowError extends StatelessWidget {
  const CustomShowError({
    super.key, required this.error,
  });
  final String? error;
  @override
  Widget build(BuildContext context) {
    return Text('Hata: ${error}');
  }
}