import 'package:get/get.dart';

import '../controllers/order_details_cancelled_controller.dart';

class OrderDetailsCancelledBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsCancelledController>(
      () => OrderDetailsCancelledController(),
    );
  }
}
