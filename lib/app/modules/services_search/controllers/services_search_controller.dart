import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ServicesSearchController extends GetxController with ScrollMixin, StateMixin<List<ServiceModel>> {
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
      final List<ServiceModel> serviceDataList = List<ServiceModel>.from(
        responseModel.data['data']['data'].map((category) => ServiceModel.fromJson(category)),
      );

      _services.addAll(serviceDataList);

      if (_services.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_services, status: RxStatus.success());

      isPagination = responseModel.data['data']['pagination']['is_pagination'] as bool;
    }
  }

  void toggleFavorite(int serviceId) {
    final service = _services.firstWhere(
      (p) => p.id == serviceId,
    );
    service.isFavorite = !service.isFavorite;
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

    await getServices();

    Get.back();
  }

  @override
  Future<void> onTopScroll() async {
    print('onTopScroll');
  }
}

class BranchSearchController extends GetxController with StateMixin<List> {
  @override
  void onInit() {
    getBranch();
    // TODO: implement onInit
    super.onInit();
  }

  void getBranch() async {
    ResponseModel responseModel = await WebServices().getBranches(
      page: 1,
    );

    if (responseModel.data["success"]) {
      if (responseModel.data["data"]["data"] == 0) {
        change([], status: RxStatus.empty());
      }

      change(responseModel.data["data"]["data"], status: RxStatus.success());

      return;
    }

    change(null, status: RxStatus.error());
  }
}
