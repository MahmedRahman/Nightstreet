import 'package:get/get.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ServiceCategoriesController extends GetxController with StateMixin {
  @override
  void onInit() {
    getServiceCategories();
    super.onInit();
  }

  void getServiceCategories() async {
    change(null, status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().getServicesCategories();

    if (responseModel.data["success"]) {
      final List<dynamic> servicesDataList = responseModel.data["data"];

      if (servicesDataList.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(responseModel.data["data"], status: RxStatus.success());
      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }
}
