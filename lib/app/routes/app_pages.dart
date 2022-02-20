import 'package:bottrading/app/ui/pages/bot_page/bot_page.dart';
import 'package:bottrading/app/ui/pages/home_page/home_page.dart';
import 'package:get/get.dart';

import '../bindings/bot2_binding.dart';
import '../bindings/bot_binding.dart';
import '../ui/pages/bot2_page/bot2_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.BOT,
      page: () => BotPage(),
      binding: BotBinding(),
    ),
    GetPage(
      name: Routes.BOT2,
      page: () => Bot2Page(),
      binding: Bot2Binding(),
    ),
  ];
}
