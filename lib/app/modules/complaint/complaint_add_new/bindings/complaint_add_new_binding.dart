import 'package:get/get.dart';

import '../controllers/complaint_add_new_controller.dart';

class ComplaintAddNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintAddNewController>(
      () => ComplaintAddNewController(),
    );
  }
}
