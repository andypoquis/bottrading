import 'package:bottrading/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  navigationBot1() {
    Get.toNamed(Routes.BOT);
  }

  navigationBot2() {
    Get.toNamed(Routes.BOT2);
  }
}
