import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:path_provider/path_provider.dart';

class ParseDatabase{
  static Future<void> initParse() async {
    Directory? appDocumentsDir;
    if(!kIsWeb){
      appDocumentsDir=await getApplicationDocumentsDirectory();
    }
    const keyApplicationId='7KCwQtjxtfLR70PEOJs8nCyuK18ARtSMGy6wEC0j';
    const keyClientKey='yJEuPow7ETiTJPtNQfGBsB2x9IaUlqnKq9UL285W';
    const keyParseServerUrl='https://parseapi.back4app.com';
    const liveQueryUrl='https://cepnak.b4a.io';
    await Parse().initialize(keyApplicationId,keyParseServerUrl,clientKey: keyClientKey,autoSendSessionId: true,debug: true,liveQueryUrl : liveQueryUrl,
       coreStore:await CoreStoreSembastImp.getInstance(kIsWeb ? "/data" : "${appDocumentsDir?.path}/data")
    );
  }
}

/*const keyApplicationId='g1pl4iwDA6lgGJHexPWyD1eR8EekQS6rn2iaA8Nu';
    const keyClientKey='QduskI3GzGr43XEY482pXRwfA8PzV0WiVEiPdewU';*/