import 'package:get/get.dart';

import '../controllers/services_search_controller.dart';

class ServicesSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesSearchController>(
      () => ServicesSearchController(),
    );
  }
}
