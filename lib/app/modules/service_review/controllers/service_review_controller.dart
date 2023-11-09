import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ServiceReviewController extends GetxController {


  rateOffer({
    required String appointmentId,
    required String offerId,
    required String rate,
    String? message,
  }) async {
    EasyLoading.show();

    ResponseModel responseModel = await WebServices().rateOffer(
      appointmentId: appointmentId,
      rate: rate,
      message: message,
      offerId: offerId,
    );
    EasyLoading.dismiss();

    if (responseModel.data["success"]) {
      AppDialogs.showToast(message: responseModel.data["message"]);

      return;
    }
    AppDialogs.showToast(message: responseModel.data["message"]);
  }

  rateBranch({
    required String appointmentId,
    required String branchId,
    required String rate,
    String? message,
  }) async {
    EasyLoading.show();

    ResponseModel responseModel = await WebServices().rateBranch(
      appointmentId: appointmentId,
      rate: rate,
      message: message,
      branchId: branchId,
    );
    EasyLoading.dismiss();

    if (responseModel.data["success"]) {
      AppDialogs.showToast(message: responseModel.data["message"]);

      return;
    }
    AppDialogs.showToast(message: responseModel.data["message"]);
  }

  rateDoctor({
    required String appointmentId,
    required String doctorId,
    required String rate,
    String? message,
  }) async {
    EasyLoading.show();

    ResponseModel responseModel = await WebServices().rateDoctor(
      appointmentId: appointmentId,
      rate: rate,
      message: message,
      doctorId: doctorId,
    );
    EasyLoading.dismiss();

    if (responseModel.data["success"]) {
      AppDialogs.showToast(message: responseModel.data["message"]);

      return;
    }
    AppDialogs.showToast(message: responseModel.data["message"]);
  }
}
