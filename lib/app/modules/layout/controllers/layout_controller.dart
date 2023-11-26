import 'package:get/get.dart';
import 'package:krzv2/services/app_version_service.dart';

class LayoutController extends GetxController {
  final appVersion = Get.find<AppVersionService>();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
