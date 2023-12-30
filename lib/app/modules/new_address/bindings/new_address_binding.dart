import 'package:get/get.dart';

import '../controllers/new_address_controller.dart';

class NewAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewAddressController>(
      () => NewAddressController(),
    );
  }
}
