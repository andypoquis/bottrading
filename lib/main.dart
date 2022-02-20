import 'package:bottrading/app/bindings/bot_binding.dart';
import 'package:bottrading/app/ui/theme/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/home_binding.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    theme: ThemeData(
      primarySwatch: primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme(
        headline1: TextStyle(
            color: Color(0xff404040),
            fontSize: 72.0,
            fontWeight: FontWeight.bold),
        bodyText2: TextStyle(
          color: Color(0xff404040),
          fontSize: 12.0,
        ),
      ),
    ),
    defaultTransition: Transition.fade,
    initialBinding: HomeBinding(),
    getPages: AppPages.pages,
  ));
}
