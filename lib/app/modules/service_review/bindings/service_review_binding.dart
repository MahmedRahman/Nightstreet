import 'package:get/get.dart';

import '../controllers/service_review_controller.dart';

class ServiceReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceReviewController>(
      () => ServiceReviewController(),
    );
  }
}
