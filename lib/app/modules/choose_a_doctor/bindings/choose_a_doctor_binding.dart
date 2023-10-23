import 'package:get/get.dart';

import '../controllers/choose_a_doctor_controller.dart';

class ChooseADoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseADoctorController>(
      () => ChooseADoctorController(),
    );
  }
}
