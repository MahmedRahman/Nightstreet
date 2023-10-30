import 'package:get/get.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OrderDetailsController>(
      OrderDetailsController(),
    );
  }
}
