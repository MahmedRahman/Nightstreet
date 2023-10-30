import 'package:get/get.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ClinicAboutInfoController extends GetxController with StateMixin {
  //TODO: Implement ClinicInfoController

  @override
  void onInit() {
    getBranchesSingle(
      branchesId: 7,
    );
    super.onInit();
  }

  void getBranchesSingle({required int branchesId}) async {
    ResponseModel responseModel = await WebServices().getBranchesSingle(
      branchesId: branchesId,
    );

    if (responseModel.data["success"]) {
      change(responseModel.data["data"], status: RxStatus.success());

      return;
    }

    change(null, status: RxStatus.error());
  }
}

class ClinicServicesController extends GetxController with StateMixin<List> {
  @override
  void onInit() {
    getOffersByBranchesId();
    super.onInit();
  }

  void getOffersByBranchesId() async {
    ResponseModel responseModel = await WebServices().getOffersByBranchesId(
      branchesId: 7,
    );

    if (responseModel.data["success"]) {
      if (responseModel.data["data"]["data"].length == 0) {
        change([], status: RxStatus.loading());
      }

      change(responseModel.data["data"]["data"], status: RxStatus.success());

      return;
    }

    change(null, status: RxStatus.error());
  }
}
