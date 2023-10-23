import 'package:get/get.dart';

import '../controllers/complaint_details_controller.dart';

class ComplaintDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintDetailsController>(
      () => ComplaintDetailsController(),
    );
  }
}
