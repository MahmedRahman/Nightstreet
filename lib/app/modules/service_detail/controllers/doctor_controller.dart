import 'package:get/get.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class DoctorController extends GetxController with StateMixin<List> {
  String serviceId = Get.arguments.toString();

  @override
  void onInit() async {
    super.onInit();
    await getListOfferDoctors();
  }

  Future getListOfferDoctors() async {
    change(null, status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getListOfferDoctors(
      id: serviceId.toString(),
    );

    if (responseModel.data["success"]) {
      change(responseModel.data["data"]["data"], status: RxStatus.success());
    }
  }
}
