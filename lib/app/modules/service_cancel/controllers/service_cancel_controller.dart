import 'package:get/get.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ServiceCancelController extends GetxController with StateMixin {
  @override
  void onInit() {
    fetchAppointmentCancelReasons();
    super.onInit();
  }

  void fetchAppointmentCancelReasons() async {
    change(null, status: RxStatus.loading());
    ResponseModel responseModel =
        await WebServices().getAppointmentsCancelReasons();

    if (responseModel.data["success"]) {
      final List<dynamic> categoryDataList = responseModel.data["data"];

      if (categoryDataList.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(responseModel.data["data"], status: RxStatus.success());
      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }
}
