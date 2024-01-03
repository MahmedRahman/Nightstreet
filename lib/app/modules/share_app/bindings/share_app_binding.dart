import 'package:get/get.dart';

import '../controllers/share_app_controller.dart';

class ShareAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareAppController>(
      () => ShareAppController(),
    );
  }
}
