import 'package:get/get.dart';

import '../controllers/complaint_active_list_controller.dart';

class ComplaintActiveListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintActiveListController>(
      () => ComplaintActiveListController(),
    );
  }
}
