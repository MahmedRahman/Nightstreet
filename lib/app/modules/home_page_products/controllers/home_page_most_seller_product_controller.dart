import 'package:get/get.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class MostSelleerProductController extends GetxController
    with StateMixin<List<ProductModel>> {
  final productList = Rx<List<ProductModel>?>([]);
  @override
  void onInit() {
    getMostSellerProducts();
    super.onInit();
  }

  void getMostSellerProducts() async {
    change(null, status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().getProducts(
      filter: 'most salled',
    );

    if (responseModel.data["success"]) {
      productList.value!.clear();
      final List<ProductModel> productDataList = List<ProductModel>.from(
        responseModel.data['data']['data']
            .map((category) => ProductModel.fromJson(category)),
      );

      productList.value?.addAll(productDataList);

      if (productDataList.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(productDataList, status: RxStatus.success());
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
