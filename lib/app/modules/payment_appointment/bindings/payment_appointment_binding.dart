import 'package:get/get.dart';

import '../controllers/payment_appointment_controller.dart';

class PaymentAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentAppointmentController>(
      () => PaymentAppointmentController(),
    );
  }
}
