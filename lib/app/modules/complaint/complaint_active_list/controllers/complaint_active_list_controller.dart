import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/models/complaint_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ComplaintActiveListController extends GetxController
    with StateMixin<List<ComplaintModel>>, ScrollMixin {
  final List<ComplaintModel> _activeComplaints = [];
  int currentPage = 1;
  bool? isPagination;
  @override
  void onInit() {
    getComplaints();
    super.onInit();
  }

  resetPaginationData() {
    currentPage = 1;
    _activeComplaints.clear();
    update();
  }

  void getComplaints() async {
    if (currentPage == 1) {
      change([], status: RxStatus.loading());
      _activeComplaints.clear();
    }

    ResponseModel responseModel = await WebServices().getComplaints(
      filter: 1,
      page: currentPage,
    );

    if (responseModel.data["success"]) {
      final List<ComplaintModel> serviceDataList = List<ComplaintModel>.from(
        responseModel.data['data']['data']
            .map((category) => ComplaintModel.fromJson(category)),
      );

      _activeComplaints.addAll(serviceDataList);

      if (_activeComplaints.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_activeComplaints, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
    }

    if (responseModel.data["success"] == false) {
      change([], status: RxStatus.error(responseModel.data["message"]));
      return;
    }
  }

  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;
    currentPage++;

    print('start paginate');

    Get.dialog(
      const Center(
        child: SpinKitCircle(
          color: AppColors.mainColor,
          size: 70,
        ),
      ),
    );

    await Future.delayed(Duration(milliseconds: 500));

    getComplaints();

    Get.back();
  }

  @override
  Future<void> onTopScroll() {
    // TODO: implement onTopScroll
    throw UnimplementedError();
  }
}
