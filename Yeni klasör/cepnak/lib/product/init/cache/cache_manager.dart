import 'package:cepnak/product/constant/cache_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager{
  static CacheManager _instance=CacheManager._init();
  static CacheManager get instance=>_instance;
  SharedPreferences? _preferences;

  CacheManager._init()  {
    SharedPreferences.getInstance().then((value) => {
      _preferences=value
    });
  }
  static initShared()async{
    if(_instance._preferences==null) {
      _instance._preferences= await SharedPreferences.getInstance();
    }
  }

  void setStringValue(CacheKeys key,String value)async {
    await _preferences?.setString(key.toString(), value);
  }
  String? getStringValue(CacheKeys key)=> _preferences?.getString(key.toString());

  void setBoolValue(CacheKeys key,bool value)async {
    await _preferences?.setBool(key.toString(),value);
  }
  bool? getBoolValue(CacheKeys key)=>_preferences?.getBool(key.toString());

}