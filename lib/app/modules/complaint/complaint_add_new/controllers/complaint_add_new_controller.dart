import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/complaint/complaint_active_list/controllers/complaint_active_list_controller.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/complaint_category_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ComplaintAddNewController extends GetxController
    with StateMixin<List<ComplaintCategoryModel>> {
  final subCategories = Rx<List<ComplaintCategoryModel>>([]);
  @override
  void onInit() async {
    await getComplaintsCategories();
    super.onInit();
  }

  List<ComplaintCategoryModel> CategoriesList = [];

  Future getComplaintsCategories() async {
    change([], status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().getComplaintsCategories();

    if (responseModel.data["success"]) {
      final List<ComplaintCategoryModel> serviceDataList =
          List<ComplaintCategoryModel>.from(
        responseModel.data['data']
            .map((category) => ComplaintCategoryModel.fromJson(category)),
      );

      CategoriesList.addAll(serviceDataList);

      if (serviceDataList.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(serviceDataList, status: RxStatus.success());

      /// init sub category list
      subCategories.value = serviceDataList.first.subCategories;
      return;
    }

    if (responseModel.data["success"] == false) {
      change([], status: RxStatus.error(responseModel.data["message"]));
      return;
    }
  }

  void saveComplaint({
    required String description,
    required String categoryId,
    File? file,
  }) async {
    EasyLoading.show();
    ResponseModel responseModel = await WebServices().addComplaintsStore(
      description: description,
      categoryId: categoryId,
      file: file,
    );

    EasyLoading.dismiss();
    if (responseModel.data["success"]) {
      final bottomBarController = Get.find<MyBottomNavigationController>();
      AppDialogs.complaintAddNewSuccessful(
        onTap: () {
          Get.offAndToNamed(Routes.LAYOUT);
          bottomBarController.changePage(4);
          Get.toNamed(Routes.COMPLAINT_MANAGER);

          ComplaintActiveListController controller = Get.find();
          controller.getComplaints();
        },
      );
      return;
    }

    if (responseModel.data["success"] == false) {
      change([], status: RxStatus.error(responseModel.data["message"]));
      return;
    }
  }
}
