import 'package:get/get.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ReviewInformationController extends GetxController with StateMixin<List> {
  String serviceId = Get.arguments.toString();

  @override
  void onInit() async {
    super.onInit();
    await getListOfferRates();
  }

  Future getListOfferRates() async {
    change(null, status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getListOfferRates(
      id: serviceId.toString(),
    );

    if (responseModel.data["success"]) {
      if ((responseModel.data["data"]["data"] as List).length == 0) {
        change([], status: RxStatus.empty());
        return;
      }

      change(responseModel.data["data"]["data"], status: RxStatus.success());
    }
  }
}
