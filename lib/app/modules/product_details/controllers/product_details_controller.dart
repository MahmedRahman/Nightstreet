import 'package:get/get.dart';
import 'package:krzv2/app/modules/product_details/controllers/similar_product_controller.dart';
import 'package:krzv2/models/product_image_model.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ProductDetailsController extends GetxController with StateMixin<ProductModel> {
  void fetchProductDetails({required String productId}) async {
    change(null, status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getSingleProduct(id: productId);

    if (responseModel.data["success"]) {
      final ProductModel product = ProductModel.fromJson(responseModel.data['data']);

      final similarProductController = Get.put(SimilarProductController());
      similarProductController.getMostSimilarProducts(
        categoryId: product.categories.first.id.toString(),
      );

      // product.images.insert(
      //   0,
      //   ProductImage(id: -1, image: product.image),
      // );

      change(product, status: RxStatus.success());
      return;
    }

    change(null, status: RxStatus.error(responseModel.data["message"]));
  }

  RxInt productCount = 1.obs;
  void increment() => productCount.value++;
  void decrement() {
    if (productCount.value == 1) {
      return;
    }
    productCount.value--;
  }
}
