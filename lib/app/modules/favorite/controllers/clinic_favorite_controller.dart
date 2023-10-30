import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/toast_component.dart';
import 'package:krzv2/models/branch_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_enums.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class CliniFavoriteController extends GetxController
    with ScrollMixin, StateMixin<List<BranchModel>> {
  final List<BranchModel> clinics = [];
  int currentPage = 1;
  bool? isPagination;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    getFavorite();
    super.onInit();
  }

  resetPaginationValues() {
    clinics.clear();
    searchQuery = ''.obs;
    currentPage = 1;
  }

  getFavorite() async {
    if (currentPage == 1) change([], status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getFavorites(
      type: FavoriteEnum.branch.name,
      pageNo: currentPage,
    );

    if (responseModel.data["success"]) {
      final List<BranchModel> productDataList = List<BranchModel>.from(
        responseModel.data['data']['data']
            .map((branch) => BranchModel.fromJson(branch)),
      );

      clinics.addAll(productDataList);

      if (clinics.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(clinics, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
    }
  }

  Future<void> addRemoveBranchFromFavorite({
    required int branchId,
    Function()? onError,
    Function()? onSuccess,
  }) async {
    ResponseModel response = await WebServices().addAndDeleteFavorites(
      id: branchId.toString(),
      type: FavoriteEnum.branch.name,
    );

    if (response.data["success"] == false) {
      if (onError != null) onError();
      showToast(message: response.data["message"]);
      return;
    }

    if (onSuccess != null) onSuccess();
  }

  void toggleFavorite(int offerId) {
    final clinic = clinics.firstWhere(
      (p) => p.id == offerId,
    );
    clinic.isFavorite = !clinic.isFavorite;
    update();
  }

  void removeClinicFromList(int productId) {
    clinics.removeWhere(
      (p) => p.id == productId,
    );

    if (clinics.length == 0) {
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
