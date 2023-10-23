import 'package:get/get.dart';

import '../controllers/complaint_closed_list_controller.dart';

class ComplaintClosedListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintClosedListController>(
      () => ComplaintClosedListController(),
    );
  }
}
