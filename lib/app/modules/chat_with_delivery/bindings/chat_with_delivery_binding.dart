import 'package:get/get.dart';

import '../controllers/chat_with_delivery_controller.dart';

class ChatWithDeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatWithDeliveryController>(
      () => ChatWithDeliveryController(),
    );
  }
}
