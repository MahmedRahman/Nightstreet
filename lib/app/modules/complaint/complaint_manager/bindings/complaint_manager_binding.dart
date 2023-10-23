import 'package:get/get.dart';

import '../controllers/complaint_manager_controller.dart';

class ComplaintManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintManagerController>(
      () => ComplaintManagerController(),
    );
  }
}
