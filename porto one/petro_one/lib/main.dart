import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:petro_one/common/resources/theme_manager.dart';
import 'package:petro_one/common/routes/pages.dart';
import 'package:petro_one/features/splash/binding/splash_binding.dart';
import 'package:petro_one/generated/l10n.dart';

import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (
      BuildContext context,
      Orientation orientation,
      DeviceType deviceType,
    ) {
      return GetMaterialApp(
        title: 'Petro One',
        debugShowCheckedModeBanner: false,
        theme: applicationThemeLight,
        darkTheme: applicationThemeDark,
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Get.deviceLocale,
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: PagesString.initial,
        initialBinding: SplashBinding(),
        getPages: AppPages.pages,
        navigatorKey: Get.key,
      );
    });
  }
}
