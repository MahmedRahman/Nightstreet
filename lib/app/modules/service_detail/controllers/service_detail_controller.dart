import 'package:get/get.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ServiceDetailController extends GetxController with StateMixin {
  String serviceId = Get.arguments.toString();

  @override
  void onInit() {
    getServiceDetail();
    super.onInit();
  }

  void getServiceDetail() async {
    change(null, status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getSingleOffers(
      id: serviceId.toString(),
    );

    if (responseModel.data["success"]) {
      // responseModel.data["data"]["data"]["images"].insert(
      //   0,
      //   responseModel.data["data"]["data"]["image"],
      // );

      change(responseModel.data["data"], status: RxStatus.success());
    }
  }
}
