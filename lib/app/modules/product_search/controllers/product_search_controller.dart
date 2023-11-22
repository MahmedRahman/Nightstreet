import 'package:get/get.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/models/product_search_query.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ProductSearchController extends GetxController
    with StateMixin<List<ProductModel>>, ScrollMixin {
  final List<ProductModel> productList = [];
  int currentPage = 1;
  bool? isPagination;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    change([], status: RxStatus.success());
    super.onInit();
  }

  resetSearchValues() {
    productList.clear();
    searchQuery = ''.obs;
    currentPage = 1;
    change([], status: RxStatus.success());
  }

  Future<void> getProducts() async {
    if (currentPage == 1) change(null, status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getProducts(
      page: currentPage,
      queryParameters: ProductQueryParameters(
        name: searchQuery.value,
      ),
    );

    if (responseModel.data["success"]) {
      final List<ProductModel> productDataList = List<ProductModel>.from(
        responseModel.data['data']['data']
            .map((category) => ProductModel.fromJson(category)),
      );

      productList.addAll(productDataList);

      if (productList.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(productList, status: RxStatus.success());
      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }

  void toggleFavorite(int productId) {
    final product = productList.firstWhere(
      (p) => p.id == productId,
    );
    product.isFavorite = !product.isFavorite;
    update();
  }

  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;
    currentPage++;

    change(productList, status: RxStatus.loadingMore());

    await getProducts();
  }

  @override
  Future<void> onTopScroll() async {}
}
