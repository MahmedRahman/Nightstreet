import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/market_model.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_enums.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class MarketFavoriteController extends GetxController
    with ScrollMixin, StateMixin<List<MarketModel>> {
  final List<MarketModel> markets = [];
  final marketsFavoriteIds = Rx<List<int>?>([]);
  int currentPage = 1;
  bool? isPagination;

  @override
  void onInit() {
    if (Get.find<AuthenticationController>().isLoggedIn) getFavorite();
    super.onInit();
  }

  resetPaginationValues() {
    markets.clear();

    currentPage = 1;
  }

  getFavorite() async {
    if (currentPage == 1) {
      change([], status: RxStatus.loading());
      marketsFavoriteIds.value?.clear();
    }

    ResponseModel responseModel = await WebServices().getFavorites(
      type: FavoriteEnum.market.name,
      pageNo: currentPage,
    );

    if (responseModel.data["success"]) {
      final List<MarketModel> marketDataList = List<MarketModel>.from(
        responseModel.data['data']['data']
            .map((market) => MarketModel.fromMap(market)),
      );

      markets.addAll(marketDataList);
      markets.map((e) => marketsFavoriteIds.value?.add(e.id)).toList();

      if (markets.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(markets, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
    }
  }

  Future<void> addRemoveMarketFromFavorite({
    required int branchId,
    Function()? onError,
    Function()? onSuccess,
  }) async {
    addRemoveLocalList(branchId);
    ResponseModel response = await WebServices().addAndDeleteFavorites(
      id: branchId.toString(),
      type: FavoriteEnum.market.name,
    );

    if (response.data["success"] == false) {
      if (onError != null) onError();
      addRemoveLocalList(branchId);
      AppDialogs.showToast(message: response.data["message"]);
      return;
    }

    if (onSuccess != null) onSuccess();
  }

  bool marketIsFavorite(int marketId) =>
      marketsFavoriteIds.value!.contains(marketId);

  void toggleFavorite(int offerId) {
    final market = markets.firstWhere(
      (p) => p.id == offerId,
    );
    market.isFavorite = !market.isFavorite;
    update();
  }

  void addRemoveLocalList(int marketId) {
    if (marketsFavoriteIds.value?.contains(marketId) ?? false) {
      marketsFavoriteIds.value?.remove(marketId);
      update();
      return;
    }
    marketsFavoriteIds.value?.add(marketId);
    update();
  }

  void removeMarketFromList(int productId) {
    markets.removeWhere(
      (p) => p.id == productId,
    );

    if (markets.length == 0) {
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
  Future<void> onTopScroll() async {}
}
