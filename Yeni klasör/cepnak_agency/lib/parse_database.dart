
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
    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      liveQueryUrl: liveQueryUrl,
      autoSendSessionId: true,
      registeredSubClassMap: <String, ParseObjectConstructor>{},
      debug: true,
      //fileDirectory: kIsWeb ? "/data" : downloadDirectory!.path,
      clientKey: keyClientKey,
      coreStore: await CoreStoreSembastImp.getInstance(
        kIsWeb ? "/data" : "${appDocumentsDir!.path}/data",
      ),
    );
    final ParseInstallation installation=await ParseInstallation.currentInstallation();
    installation.subscribeToChannel('push');
    await installation.save();
  }

}//kIsWeb ? "/data" : "${appDocumentsDir?.path}/data"