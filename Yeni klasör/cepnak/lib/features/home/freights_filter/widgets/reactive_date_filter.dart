import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_date_range_picker/reactive_date_range_picker.dart';

class ReactiveDateFilter extends StatelessWidget {
  const ReactiveDateFilter({super.key, required this.formControlName,});
  final String formControlName;
  @override
  Widget build(BuildContext context) {
    return ReactiveDateRangePicker(
      firstDate: DateTime.now(),
      formControlName: formControlName,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF0EBEB),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.r))),
        helperText: ' ',
        suffixIcon:const Icon(Icons.calendar_today),
      ),
    );
  }
}