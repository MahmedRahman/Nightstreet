import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/models/product_search_query.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ProductsListController extends GetxController
    with StateMixin<List<ProductModel>>, ScrollMixin {
  final productList = Rx<List<ProductModel>?>([]);
  int currentPage = 1;
  bool? isPagination;
  ProductQueryParameters queryParams = ProductQueryParameters();
  @override
  void onInit() {
    final categoryId = (Get.arguments ?? '') as String;
    if (categoryId != '') {
      print('cat id => ${categoryId}');
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

      change(productList.value!, status: RxStatus.success());
      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
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

  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;

    currentPage++;

    Get.dialog(
      const Center(
        child: SpinKitCircle(
          color: AppColors.mainColor,
          size: 70,
        ),
      ),
    );

    await getProducts();

    Get.back();
  }

  @override
  Future<void> onTopScroll() async {
    print('onTopScroll');
  }
}
