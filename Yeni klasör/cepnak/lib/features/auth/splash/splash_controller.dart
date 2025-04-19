import 'package:cepnak/features/auth/register/register_service.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../../product/constant/cache_enums.dart';
import '../../../product/init/cache/cache_manager.dart';

class SplashController extends GetxController{
  RegisterService _service=RegisterService();
  bool hasUser=false;
  void checkUserSession() async {
    ParseUser? user = await ParseUser.currentUser() as ParseUser?;
    if(user!=null){
      hasUser=await _service.hasUserLogged();
      if (hasUser) {
        NavigatorManager.instance.pushReplacement(NavigatesRoutes.request);
      } else {
        NavigatorManager.instance.pushReplacement(CacheManager.instance.getBoolValue(CacheKeys.isFirstTime) == null|| false ? NavigatesRoutes.onBoard:NavigatesRoutes.register);
      }
    }
    else{
      NavigatorManager.instance.pushReplacement(NavigatesRoutes.register);
    }


  }
}