import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/branch_model.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_enums.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class CliniFavoriteController extends GetxController
    with ScrollMixin, StateMixin<List<BranchModel>> {
  final List<BranchModel> clinics = [];
  final clinicsFavoriteIds = Rx<List<int>?>([]);
  int currentPage = 1;
  bool? isPagination;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    if (Get.find<AuthenticationController>().isLoggedIn) getFavorite();
    super.onInit();
  }

  resetPaginationValues() {
    clinics.clear();
    searchQuery = ''.obs;
    currentPage = 1;
  }

  getFavorite() async {
    if (currentPage == 1) {
      change([], status: RxStatus.loading());
      clinicsFavoriteIds.value?.clear();
    }

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
      clinics.map((e) => clinicsFavoriteIds.value?.add(e.id)).toList();

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
    addRemoveLocalList(branchId);
    ResponseModel response = await WebServices().addAndDeleteFavorites(
      id: branchId.toString(),
      type: FavoriteEnum.branch.name,
    );

    if (response.data["success"] == false) {
      if (onError != null) onError();
      addRemoveLocalList(branchId);
      AppDialogs.showToast(message: response.data["message"]);
      return;
    }

    if (onSuccess != null) onSuccess();
  }

  bool clinicIsFavorite(int clinicId) =>
      clinicsFavoriteIds.value!.contains(clinicId);

  void toggleFavorite(int offerId) {
    final clinic = clinics.firstWhere(
      (p) => p.id == offerId,
    );
    clinic.isFavorite = !clinic.isFavorite;
    update();
  }

  void addRemoveLocalList(int clinicId) {
    if (clinicsFavoriteIds.value?.contains(clinicId) ?? false) {
      clinicsFavoriteIds.value?.remove(clinicId);
      update();
      return;
    }
    clinicsFavoriteIds.value?.add(clinicId);
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

    change(clinics, status: RxStatus.loadingMore());

    await getFavorite();

    Get.back();
  }

  @override
  Future<void> onTopScroll() async {}
}
