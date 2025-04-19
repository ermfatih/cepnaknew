import 'package:cepnak/features/auth/login/verification_code_view.dart';
import 'package:cepnak/features/home/request/request_view.dart';
import 'package:cepnak/product/i18n/strings.g.dart';
import 'package:cepnak/product/utils/dialog_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../register/register_service.dart';

class LoginViewModel extends GetxController{

  late BuildContext context;
  RxBool isActive=true.obs;
  final form=FormGroup({'phone':FormControl<String>(value: '+90',validators: [Validators.required])});
  String get _phone=> form.value['phone'].toString();
  final RegisterService _registerService=RegisterService();

  void setContext(BuildContext context){
    this.context=context;
  }

  void changeActive()=>isActive.value=!isActive.value;

  void onPressed()async{
    if(form.valid){
      DialogFunctions.showCircular(context);
      final response=await _registerService.login(phone: _phone);
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
      if(response.success){
        //showDialog(barrierDismissible: true, context: context, builder: (context) {return CustomAlertDialog();},);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RequestView()));
      }else{
        DialogFunctions.showError(context, response.error!.message.i18n);
      }
    }
    form.markAllAsTouched();
  }

  Future<dynamic> showCircular() {
    return showDialog(
      barrierDismissible: false,
      context: context, builder: (context) {
      return Center(child: CircularProgressIndicator());
    },);
  }
  Future<dynamic> showError(String error) {
    return showDialog(
      barrierDismissible: true,
      context: context, builder: (context) {
      return AlertDialog(content: Text(error),);
    },);
  }



}