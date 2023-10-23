import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/toast_component.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_enums.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class OfferFavoriteController extends GetxController
    with ScrollMixin, StateMixin<List<ServiceModel>> {
  final List<ServiceModel> _offers = [];
  int currentPage = 1;
  bool? isPagination;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    getFavorite();
    super.onInit();
  }

  resetPaginationValues() {
    _offers.clear();
    searchQuery = ''.obs;
    currentPage = 1;
  }

  getFavorite() async {
    if (currentPage == 1) change([], status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getFavorites(
      type: FavoriteEnum.offer.name,
      pageNo: currentPage,
    );

    if (responseModel.data["success"]) {
      final List<ServiceModel> productDataList = List<ServiceModel>.from(
        responseModel.data['data']['data']
            .map((category) => ServiceModel.fromJson(category)),
      );

      _offers.addAll(productDataList);

      if (_offers.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_offers, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
    }
  }

  Future<void> addRemoveOfferFromFavorite({
    required int offerId,
    Function()? onError,
    Function()? onSuccess,
  }) async {
    ResponseModel response = await WebServices().addAndDeleteFavorites(
      id: offerId.toString(),
      type: FavoriteEnum.offer.name,
    );

    if (response.data["success"] == false) {
      if (onError != null) onError();
      showToast(message: response.data["message"]);
      return;
    }

    if (onSuccess != null) onSuccess();
  }

  void toggleFavorite(int offerId) {
    final offer = _offers.firstWhere(
      (p) => p.id == offerId,
    );
    offer.isFavorite = !offer.isFavorite;
    update();
  }

  void removeOfferFromList(int productId) {
    _offers.removeWhere(
      (p) => p.id == productId,
    );

    if (_offers.length == 0) {
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
