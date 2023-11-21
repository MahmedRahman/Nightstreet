import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/models/branch_model.dart';
import 'package:krzv2/models/branch_url_model.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ServicesSearchController extends GetxController
    with ScrollMixin, StateMixin<List<ServiceModel>> {
  final List<ServiceModel> _services = [];
  int currentPage = 1;
  bool? isPagination;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    change([], status: RxStatus.success());
    super.onInit();
  }

  resetSearchValues() {
    _services.clear();
    searchQuery = ''.obs;
    currentPage = 1;
    change([], status: RxStatus.success());
  }

  getServices() async {
    if (currentPage == 1) change([], status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getServices(
      name: searchQuery.value,
      page: currentPage.toString(),
    );

    if (responseModel.data["success"]) {
      print('dddd => ${responseModel.data['data']['data']}');
      final List<ServiceModel> serviceDataList = List<ServiceModel>.from(
        responseModel.data['data']['data']
            .map((category) => ServiceModel.fromJson(category)),
      );

      _services.addAll(serviceDataList);

      if (_services.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_services, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
    }
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

    await getServices();

    Get.back();
  }

  @override
  Future<void> onTopScroll() async {}
}

class BranchSearchController extends GetxController
    with StateMixin<List<BranchModel>>, ScrollMixin {
  final List<BranchModel> _branches = [];
  int currentPage = 1;
  bool? isPagination;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    change([], status: RxStatus.success());
    super.onInit();
  }

  resetSearchValues() {
    _branches.clear();
    searchQuery = ''.obs;
    currentPage = 1;
    change([], status: RxStatus.success());
  }

  getBranches() async {
    if (currentPage == 1) change([], status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getBranches(
      page: currentPage,
      queryParameters: BranchQueryParameters(
        name: searchQuery.value,
      ),
    );

    if (responseModel.data["success"]) {
      final List<BranchModel> serviceDataList = List<BranchModel>.from(
        responseModel.data['data']['data']
            .map((category) => BranchModel.fromJson(category)),
      );

      _branches.addAll(serviceDataList);

      if (_branches.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_branches, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
    }
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

    await getBranches();

    Get.back();
  }

  @override
  Future<void> onTopScroll() async {}
}
