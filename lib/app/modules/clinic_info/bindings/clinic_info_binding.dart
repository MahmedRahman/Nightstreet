import 'package:get/get.dart';

import '../controllers/clinic_info_controller.dart';

class ClinicInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClinicInfoController>(
      () => ClinicInfoController(),
    );
  }
}
