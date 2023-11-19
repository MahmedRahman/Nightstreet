import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_enums.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class OfferFavoriteController extends GetxController
    with ScrollMixin, StateMixin<List<ServiceModel>> {
  final List<ServiceModel> _offers = [];
  final offerFavoriteIds = Rx<List<int>?>([]);
  int currentPage = 1;
  bool? isPagination;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    if (Get.find<AuthenticationController>().isLoggedIn) getFavorite();
    super.onInit();
  }

  resetPaginationValues() {
    _offers.clear();
    searchQuery = ''.obs;
    currentPage = 1;
  }

  getFavorite() async {
    if (currentPage == 1) {
      change([], status: RxStatus.loading());
      offerFavoriteIds.value?.clear();
    }

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
      _offers.map((e) => offerFavoriteIds.value?.add(e.id)).toList();

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
    addRemoveLocalList(offerId);
    ResponseModel response = await WebServices().addAndDeleteFavorites(
      id: offerId.toString(),
      type: FavoriteEnum.offer.name,
    );

    if (response.data["success"] == false) {
      if (onError != null) onError();
      addRemoveLocalList(offerId);
      AppDialogs.showToast(message: response.data["message"]);
      return;
    }

    if (onSuccess != null) onSuccess();
  }

  void addRemoveLocalList(int offerId) {
    if (offerFavoriteIds.value?.contains(offerId) ?? false) {
      offerFavoriteIds.value?.remove(offerId);
      update();
      return;
    }
    offerFavoriteIds.value?.add(offerId);
    update();
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

  bool offerIsFavorite(int serviceId) =>
      offerFavoriteIds.value!.contains(serviceId);
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
  Future<void> onTopScroll() async {}
}
