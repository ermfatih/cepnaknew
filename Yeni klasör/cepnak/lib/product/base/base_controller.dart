import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController{
  late BuildContext context;
  void setContext(BuildContext context){
    this.context=context;
  }
  void closePage() {
    NavigatorManager.instance.pop();
  }
}