import 'package:get/get.dart';

import '../controllers/shoppint_cart_controller.dart';

class ShoppintCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShoppintCartController>(
      () => ShoppintCartController(),
    );
  }
}
