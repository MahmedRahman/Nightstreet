import 'package:get/get.dart';

import '../controllers/service_cancel_controller.dart';

class ServiceCancelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceCancelController>(
      () => ServiceCancelController(),
    );
  }
}
