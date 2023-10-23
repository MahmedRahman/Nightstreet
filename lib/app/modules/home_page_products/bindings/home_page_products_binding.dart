import 'package:get/get.dart';

import '../controllers/home_page_products_controller.dart';

class HomePageProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageProductsController>(
      () => HomePageProductsController(),
    );
  }
}
