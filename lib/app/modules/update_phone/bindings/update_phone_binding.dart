import 'package:get/get.dart';

import '../controllers/update_phone_controller.dart';

class UpdatePhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePhoneController>(
      () => UpdatePhoneController(),
    );
  }
}
