import 'package:get/get.dart';
import 'package:krzv2/models/branch_model.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ClinicAboutInfoController extends GetxController with StateMixin<BranchModel> {
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

class ClinicServicesController extends GetxController with StateMixin<List<ServiceModel>> {
  final List<ServiceModel> _services = [];
  int currentPage = 1;
  bool? isPagination;
  @override
  void onInit() {
    getOffersByBranchesId(Get.arguments as int);
    super.onInit();
  }

  void getOffersByBranchesId(int branchesId) async {
    if (currentPage == 1) change([], status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().getOffersByBranchesId(
      branchesId: branchesId,
      page: currentPage,
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

      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }

  void toggleFavorite(int serviceId) {
    final service = _services.firstWhere(
      (p) => p.id == serviceId,
    );
    service.isFavorite = !service.isFavorite;
    update();
  }
}
