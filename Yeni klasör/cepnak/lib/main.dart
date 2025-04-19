
import 'package:bot_toast/bot_toast.dart';
import 'package:cepnak/features/auth/splash/splash_view.dart';
import 'package:cepnak/product/init/cache/cache_manager.dart';
import 'package:cepnak/product/init/parse_database.dart';
import 'package:cepnak/product/init/theme/light_theme.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:i18n_extension/i18n_widget.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await ParseDatabase.initParse();
  CacheManager.initShared();
  runApp( const CepNak());
}

class CepNak extends StatelessWidget {
  const CepNak({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return ScreenUtilInit(
      builder: (context, child) {
      return GetMaterialApp(
        routes:NavigatorRoutes().items,
        navigatorKey: NavigatorManager.instance.navigatorGlobalKey,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: botToastBuilder,
        supportedLocales: const[
          Locale('tr','TR'),
          Locale('en','US')],
        locale: Locale('tr','TR'),
        theme:LightTheme.instance.lightTheme,
        debugShowCheckedModeBanner: false,
        home:I18n(child: SplashView()),
      );
    },);
  }
}

