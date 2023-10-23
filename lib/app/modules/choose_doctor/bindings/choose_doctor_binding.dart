import 'package:get/get.dart';

import '../controllers/choose_doctor_controller.dart';

class ChooseDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseDoctorController>(
      () => ChooseDoctorController(),
    );
  }
}
