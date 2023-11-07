import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_enums.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ProductFavoriteController extends GetxController
    with ScrollMixin, StateMixin<List<ProductModel>> {
  final List<ProductModel> _products = [];
  final productFavoriteIds = Rx<List<int>?>([]);

  int currentPage = 1;
  bool? isPagination;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    if (Get.find<AuthenticationController>().isLoggedIn) getFavorite();
    super.onInit();
  }

  resetPaginationValues() {
    _products.clear();
    searchQuery = ''.obs;
    currentPage = 1;
  }

  getFavorite() async {
    print('start call get favorite');
    if (currentPage == 1) {
      change([], status: RxStatus.loading());
      productFavoriteIds.value?.clear();
    }

    ResponseModel responseModel = await WebServices().getFavorites(
      type: FavoriteEnum.product.name,
      pageNo: currentPage,
    );

    if (responseModel.data["success"]) {
      final List<ProductModel> productDataList = List<ProductModel>.from(
        responseModel.data['data']['data']
            .map((category) => ProductModel.fromJson(category)),
      );

      _products.addAll(productDataList);
      _products.map((e) => productFavoriteIds.value?.add(e.id)).toList();

      if (_products.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_products, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
    }
  }

  Future<void> addRemoveProductFromFavorite({
    required int productId,
    Function()? onError,
    Function()? onSuccess,
  }) async {
    ResponseModel response = await WebServices().addAndDeleteFavorites(
      id: productId.toString(),
      type: FavoriteEnum.product.name,
    );

    if (response.data["success"] == false) {
      if (onError != null) onError();
      addRemoveLocalList(productId);
      AppDialogs.showToast(message: response.data["message"]);
      return;
    }

    if (onSuccess != null) onSuccess();
    addRemoveLocalList(productId);
  }

  bool productIsFavorite(int productId) =>
      productFavoriteIds.value!.contains(productId);

  void addRemoveLocalList(int productId) {
    if (productFavoriteIds.value?.contains(productId) ?? false) {
      productFavoriteIds.value?.remove(productId);
      print('fav ids list => ${productFavoriteIds.value?.length}');
      update();
      return;
    }
    productFavoriteIds.value?.add(productId);
    update();
    print('fav ids list => ${productFavoriteIds.value?.length}');
  }

  checkListIsEmpty() {
    if (productFavoriteIds.value!.isEmpty) {
      change([], status: RxStatus.empty());
      update();
    }
  }

  void removeProductFromList(int productId) {
    _products.removeWhere(
      (p) => p.id == productId,
    );

    if (_products.length == 0) {
      change([], status: RxStatus.empty());
    }

    update();
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

    await getFavorite();

    Get.back();
  }

  @override
  Future<void> onTopScroll() async {
    print('onTopScroll');
  }
}
