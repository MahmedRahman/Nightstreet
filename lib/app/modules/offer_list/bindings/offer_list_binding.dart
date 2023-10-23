import 'package:get/get.dart';

import '../controllers/offer_list_controller.dart';

class OfferListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferListController>(
      () => OfferListController(),
    );
  }
}
