import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';

class ReactiveTimeFilter extends StatelessWidget {
  const ReactiveTimeFilter({super.key, required this.formControlName, required this.label,});
  final String formControlName;
  final String label;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.4.sw,
      child: ReactiveDateTimePicker(
        formControlName: formControlName,
        type: ReactiveDatePickerFieldType.time,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xffF0EBEB),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.r))),
          helperText: ' ',
          suffixIcon:const Icon(Icons.watch_later_outlined),
        ),
      ),
    );
  }
}