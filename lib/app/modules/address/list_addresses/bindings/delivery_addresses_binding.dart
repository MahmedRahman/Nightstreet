import 'package:get/get.dart';

import '../controllers/delivery_addresses_controller.dart';

class DeliveryAddressesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryAddressesController>(
      () => DeliveryAddressesController(),
    );
  }
}
