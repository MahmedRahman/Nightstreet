import 'package:get/get.dart';

import '../controllers/about_doctor_controller.dart';

class AboutDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutDoctorController>(
      () => AboutDoctorController(),
    );
  }
}
