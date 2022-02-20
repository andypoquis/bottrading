
import 'package:get/get.dart';
import '../controllers/bot_controller.dart';


class BotBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BotController>(() => BotController());
  }
}