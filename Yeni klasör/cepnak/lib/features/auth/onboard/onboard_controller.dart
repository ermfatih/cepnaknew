import 'package:cepnak/product/constant/cache_enums.dart';
import 'package:cepnak/product/init/cache/cache_manager.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController{
  void changeFirstTime(){
    CacheManager.instance.setBoolValue(CacheKeys.isFirstTime, true);
  }
}