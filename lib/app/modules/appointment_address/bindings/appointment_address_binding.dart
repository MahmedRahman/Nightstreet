import 'package:get/get.dart';

import '../controllers/appointment_address_controller.dart';

class AppointmentAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentAddressController>(
      () => AppointmentAddressController(),
    );
  }
}
