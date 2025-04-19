import 'package:flutter/material.dart';

class TimeFilter extends StatefulWidget {
  const TimeFilter({super.key,});

  @override
  State<TimeFilter> createState() => _TimeFilterState();
}

class _TimeFilterState extends State<TimeFilter> {
  List<String> list=['','1','2','3'];
  String dropDownValue='';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 80,
      child: DropdownButtonFormField(
        decoration: InputDecoration(fillColor: Color(0xffF7F2FA),
          helperText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),),
        dropdownColor: Color(0xffF7F2FA),
        value: dropDownValue,
        items: list.map((e) => DropdownMenuItem(value:e ,child: Text(e))).toList(), onChanged: (value) {
        setState(() {
          dropDownValue=value!;
        });
      },),
    );
  }
}
