
import 'package:get/get.dart';
import '../controllers/bot2_controller.dart';


class Bot2Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Bot2Controller>(() => Bot2Controller());
  }
}