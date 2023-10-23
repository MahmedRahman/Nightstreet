import 'package:get/get.dart';

import '../controllers/services_reviews_controller.dart';

class ServicesReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesReviewsController>(
      () => ServicesReviewsController(),
    );
  }
}
