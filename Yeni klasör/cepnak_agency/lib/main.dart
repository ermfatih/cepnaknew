import 'package:bot_toast/bot_toast.dart';
import 'package:cepnak_agency/firebase_options.dart';
import 'package:cepnak_agency/parse_database.dart';
import 'package:cepnak_agency/router.dart';
import 'package:cepnak_agency/translations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:i18n_extension/i18n_widget.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MyI18n.loadTranslations();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ParseDatabase.initParse();
  await FirebaseMessaging.instance.getInitialMessage();
  runApp(ProviderScope(child: I18n(child: const MyApp()),));


}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    Translations.recordMissingTranslations = false;
    Translations.recordMissingKeys = false;
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp.router(
        routerConfig: ref.watch(routeProvider),
        localizationsDelegates: const[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale:const Locale('tr'),
        supportedLocales: const[
          Locale('tr'),
          Locale('en'),
        ],
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        title: 'Cepnak',
        theme: ThemeData(),
      ),
    );
  }
}

