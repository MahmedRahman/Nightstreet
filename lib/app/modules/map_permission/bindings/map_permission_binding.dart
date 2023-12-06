import 'package:get/get.dart';

import '../controllers/map_permission_controller.dart';

class MapPermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapPermissionController>(
      () => MapPermissionController(),
    );
  }
}
