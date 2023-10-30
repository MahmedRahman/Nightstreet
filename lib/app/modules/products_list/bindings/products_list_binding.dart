import 'package:get/get.dart';
import 'package:krzv2/app/modules/commercial_brands/controllers/product_brand_controller.dart';

import '../controllers/products_list_controller.dart';

class ProductsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsListController>(
      () => ProductsListController(),
    );
    Get.put<ProductsBrandController>(
      ProductsBrandController(),
    );
  }
}
