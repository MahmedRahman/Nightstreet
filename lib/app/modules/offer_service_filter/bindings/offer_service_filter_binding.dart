import 'package:get/get.dart';

import '../controllers/offer_service_filter_controller.dart';

class OfferServiceFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferServiceFilterController>(
      () => OfferServiceFilterController(),
    );
  }
}
