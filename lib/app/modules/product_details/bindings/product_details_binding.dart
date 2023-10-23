import 'package:get/get.dart';
import 'package:krzv2/app/modules/product_details/controllers/product_review_controller.dart';
import 'package:krzv2/app/modules/product_details/controllers/similar_product_controller.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailsController>(
      () => ProductDetailsController(),
    );
    Get.lazyPut<ProductReviewController>(
      () => ProductReviewController(),
    );
  }
}
