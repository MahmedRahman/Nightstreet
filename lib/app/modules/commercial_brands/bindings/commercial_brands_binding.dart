import 'package:get/get.dart';

import '../controllers/commercial_brands_controller.dart';

class CommercialBrandsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommercialBrandsController>(
      () => CommercialBrandsController(),
    );
  }
}
