import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveFilterSlider extends StatelessWidget {
  const ReactiveFilterSlider({super.key, required this.formControlName});
  final String formControlName;
  @override
  Widget build(BuildContext context) {
    return ReactiveSlider(
      formControlName: formControlName,
      //secondaryActiveColor: Colors.black,
      activeColor:const Color(0xff6750A4),
      inactiveColor:const Color(0xffE6E0E9),
      labelBuilder: (value) => value.round().toString(),
      max: 20,
      min: 0,
      onChanged: (value) {},);
  }
}
