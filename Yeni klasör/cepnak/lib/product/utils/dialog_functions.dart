import 'package:flutter/material.dart';

class DialogFunctions{
  static Future<dynamic> showCircular(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context, builder: (context) {
      return Center(child: CircularProgressIndicator());
    },);
  }
  static Future<dynamic> showError(BuildContext context, String error) {
    return showDialog(
      barrierDismissible: true,
      context: context, builder: (context) {
      return AlertDialog(content: Text(error),);
    },);
  }
  static Future<dynamic> showInfo(BuildContext context, String text) {
    return showDialog(
      context: context, builder: (context) {
      return AlertDialog(content: Text(text),);
    },);
  }

}