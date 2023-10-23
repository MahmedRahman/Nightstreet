import 'package:get/get.dart';

import '../controllers/verify_phone_controller.dart';

class VerifyPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyPhoneController>(
      () => VerifyPhoneController(),
    );
  }
}
