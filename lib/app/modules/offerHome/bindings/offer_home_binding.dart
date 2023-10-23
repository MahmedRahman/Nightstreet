import 'package:get/get.dart';

import '../controllers/offer_home_controller.dart';

class OfferHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferHomeController>(
      () => OfferHomeController(),
    );
  }
}
