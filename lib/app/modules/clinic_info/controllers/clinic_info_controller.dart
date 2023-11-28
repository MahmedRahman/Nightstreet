import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/models/branch_model.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ClinicAboutInfoController extends GetxController
    with StateMixin<BranchModel> {
  @override
  void onInit() {
    getBranchesSingle(
      branchesId: Get.arguments,
    );
    super.onInit();
  }

  void getBranchesSingle({required int branchesId}) async {
    ResponseModel responseModel = await WebServices().getBranchesSingle(
      branchesId: branchesId,
    );

    if (responseModel.data["success"]) {
      final branch = BranchModel.fromJson(responseModel.data["data"]);
      print("BranchModel ${responseModel.data["data"]}");
      print("BranchModel ${responseModel.data["data"]["clinic"]["image"]}");

      change(branch, status: RxStatus.success());

      return;
    }

    change(null, status: RxStatus.error());
  }
}

class ClinicServicesController extends GetxController with StateMixin {
  int currentPage = 1;
  bool? isPagination;
  RxInt branchId = 0.obs;

  final pagingController =
      PagingController<int, ServiceModel>(firstPageKey: 1).obs;

  @override
  void onInit() {
    branchId.value = Get.arguments as int;
    pageListener();
    super.onInit();
  }

  void pageListener() {
    pagingController.value.addPageRequestListener(
      (pageKey) {
        currentPage = pageKey;
        getOffersByBranchesId();
      },
    );
  }

  void getOffersByBranchesId() async {
    if (currentPage == 1) change([], status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().getOffersByBranchesId(
      branchesId: branchId.value,
      page: currentPage,
    );

    if (responseModel.data["success"]) {
      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;

      final newItems = List<ServiceModel>.from(
        responseModel.data['data']['data']
            .map((item) => ServiceModel.fromJson(item)),
      );
      final isPaginate =
          responseModel.data['data']['pagination']['is_pagination'] as bool;

      if (isPaginate == false) {
        pagingController.value.appendLastPage(newItems.toSet().toList());
      } else {
        final nextPageKey = currentPage + 1;
        pagingController.value
            .appendPage(newItems.toSet().toList(), nextPageKey);
      }

      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }
}
