import 'package:get/get.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_product_view.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/models/product_search_query.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class OfferProductController extends GetxController
    with StateMixin<List<ProductModel>>, ScrollMixin {
  final productList = Rx<List<ProductModel>?>([]);
  int currentPage = 1;
  bool? isPagination;
  ProductQueryParameters queryParams = ProductQueryParameters(adminFeatured: 1);
  @override
  void onInit() {
    getOffersProduct();
    super.onInit();
  }

  Future<void> getOffersProduct() async {
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

      KProductHighestPrice.value = responseModel.data["data"]["highest_price"];

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }

  productFilter() {
    change([], status: RxStatus.loading());
    productList.value!.clear();
    currentPage = 1;
    getOffersProduct();
  }

  resetSearchValues() {
    productList.value!.clear();
    currentPage = 1;
    change([], status: RxStatus.success());
  }

  void onFilterDataChanged(ProductQueryParameters productQueryParameters) {
    queryParams.filter = productQueryParameters.filter;
    queryParams.startPrice = productQueryParameters.startPrice;
    queryParams.endPrice = productQueryParameters.endPrice;
    queryParams.brandIds = productQueryParameters.brandIds;

    productFilter();
  }

  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;

    currentPage++;

    change(productList.value, status: RxStatus.loadingMore());

    await getOffersProduct();
  }

  @override
  Future<void> onTopScroll() async {}
}
