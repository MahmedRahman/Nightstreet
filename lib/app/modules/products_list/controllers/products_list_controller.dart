import 'package:get/get.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_product_view.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/models/product_search_query.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ProductsListController extends GetxController
    with StateMixin<List<ProductModel>>, ScrollMixin {
  final productList = Rx<List<ProductModel>?>([]);

  ProductQueryParameters queryParams = ProductQueryParameters();
  @override
  void onInit() {
    final categoryId = (Get.arguments ?? '') as String;
    if (categoryId != '') {
      queryParams.categoryId = categoryId;

      productFilter();
      update();
    } else {
      getProducts();
    }

    super.onInit();
  }

  Future<void> getProducts() async {
    if (currentPage == 1) change(null, status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getProducts(
      page: currentPage,
      queryParameters: queryParams,
    );

    if (responseModel.data["success"]) {
      final List<ProductModel> productDataList = List<ProductModel>.from(
        responseModel.data['data']['data']
            .map((category) => ProductModel.fromJson(category)),
      );

      productList.value?.addAll(productDataList);

      if (productList.value!.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      KProductHighestPrice.value = responseModel.data["data"]["highest_price"];

      change(productList.value!, status: RxStatus.success());
      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }

  Future<void> pullToRefresh() async {
    currentPage = 1;
    productList.value!.clear();
    getProducts();
  }

  productFilter() {
    change([], status: RxStatus.loading());
    productList.value!.clear();
    currentPage = 1;
    getProducts();
  }

  int currentPage = 1;
  bool? isPagination;
  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;

    currentPage++;

    change(productList.value, status: RxStatus.loadingMore());

    await getProducts();
  }

  @override
  Future<void> onTopScroll() async {}
}
