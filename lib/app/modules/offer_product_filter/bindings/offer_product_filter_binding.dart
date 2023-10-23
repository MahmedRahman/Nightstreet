import 'package:get/get.dart';

import '../controllers/offer_product_filter_controller.dart';

class OfferProductFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferProductFilterController>(
      () => OfferProductFilterController(),
    );
  }
}
