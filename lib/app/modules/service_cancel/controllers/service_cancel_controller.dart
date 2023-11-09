import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/appointment_mangment/controllers/appointment_mangment_controller.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
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

  cancelAppointment({
    required String orderId,
    required List<String> reasondIds,
  }) async {
    EasyLoading.show();

    ResponseModel responseModel = await WebServices().cancelAppointment(
      appointmentId: orderId.toString(),
      reasondIds: reasondIds,
    );
    EasyLoading.dismiss();

    if (responseModel.data["success"]) {
      AppDialogs.showToast(message: responseModel.data["message"]);

      Get.find<AppointmentMangmentController>().fetchAppointmentByType(1);

      Get.toNamed(Routes.APPOINTMENT_MANGMENT);

      return;
    }
    AppDialogs.showToast(message: responseModel.data["message"]);
  }
}
