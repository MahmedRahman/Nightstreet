import 'package:get/get.dart';

import '../controllers/gift_card_payment_controller.dart';

class GiftCardPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GiftCardPaymentController>(
      () => GiftCardPaymentController(),
    );
  }
}
