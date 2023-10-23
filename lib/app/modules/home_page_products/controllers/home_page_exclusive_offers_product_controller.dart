import 'package:get/get.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ExclusiveOffersProductController extends GetxController
    with StateMixin<List<ProductModel>> {
  final productList = Rx<List<ProductModel>?>([]);
  @override
  void onInit() {
    getExclusiveOffersProducts();
    super.onInit();
  }

  void getExclusiveOffersProducts() async {
    change(null, status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().getProducts(
      adminFeatured: '1',
    );

    if (responseModel.data["success"]) {
      productList.value!.clear();
      final List<ProductModel> productDataList = List<ProductModel>.from(
        responseModel.data['data']['data']
            .map((category) => ProductModel.fromJson(category)),
      );

      productList.value?.addAll(productDataList);
      if (productList.value!.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(productList.value, status: RxStatus.success());
      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }

  void toggleFavorite(int productId) {
    final product = productList.value!.firstWhere(
      (p) => p.id == productId,
    );
    product.isFavorite = !product.isFavorite;
    update();
  }
}
