import 'package:get/get.dart';

import '../controllers/appointment_mangment_controller.dart';

class AppointmentMangmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentMangmentController>(
      () => AppointmentMangmentController(),
    );
  }
}
