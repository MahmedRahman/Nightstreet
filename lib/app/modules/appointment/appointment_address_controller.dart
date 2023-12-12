import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/appointment/views/appointment_booking_h_view.dart';
import 'package:krzv2/app/modules/appointment/views/appointment_booking_view.dart';
import 'package:krzv2/app/modules/appointment/views/appointment_choose_a_doctor_view.dart';
import 'package:krzv2/app/modules/payment_bank/payment_page_new.dart';
import 'package:krzv2/app/modules/payment_bank/payment_success_page.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/api_manger.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class AppointmentController extends GetxController {
  var selectBranch;
  var selectDoctor;
  String? selectData;
  String? selectTime;
  RxString selectTimeUI = ''.obs;
  RxString selectDateUI = ''.obs;
  String? selectNote;
  var service;
  RxList AppointmentDataList = [].obs;

  final authController = Get.find<AuthenticationController>();

  void branchOfferDoctors() async {
    ResponseModel responseModel = await WebServices().getBranchOfferDoctors(
      branchId: selectBranch["id"],
      offerId: service["id"],
    );

    if (responseModel.data["success"]) {
      if (responseModel.data["data"]["data"].length == 0) {
        Get.to(
          AppointmentBookingHView(
            //serves: service,
            isDoctorSelect: false,
          ),
        );
        return;
      }

      selectDoctor = responseModel.data["data"]["data"][0];
      Get.to(
        AppointmentChooseDoctorView(
          data: responseModel.data["data"]["data"],
          serves: service,
        ),
      );
      return;
    }
  }

  RxBool timeLoading = false.obs;
  void getAvailableOfferTimes() async {
    try {
      ResponseModel responseModel;
      timeLoading.value = true;
      print("selectDoctor ${selectDoctor.toString()}");
      responseModel = await WebServices().getAvailableOfferTimes(
        offerId: service["id"],
        branchId: selectBranch["id"],
        doctorId: selectDoctor.toString() == "" ? "null" : selectDoctor["id"].toString(),
        dateTime: selectData.toString(),
      );
      timeLoading.value = false;
      if (responseModel.data["success"]) {
        AppointmentDataList.value = responseModel.data["data"];
        update();
      } else {
        AppointmentDataList.value = [];
        update();
      }
    } catch (e, st) {
      print(st);
      print(e);
    }
  }

  void bookAppointment({
    required String payment_type,
  }) async {
    EasyLoading.show();
    ResponseModel responseModel = await WebServices().bookAppointment(
      payment_type: payment_type,
      offer_id: service["id"],
      branch_id: selectBranch["id"],
      doctor_id: GetUtils.isNull(selectDoctor) ? null : selectDoctor["id"],
      date_time: selectData.toString(),
      time: selectTime.toString(),
      notes: selectNote.toString(),
    );

    EasyLoading.dismiss();

    if (responseModel.data["success"]) {
      // AppDialogs.showToast(message: responseModel.data["data"]);

      if (payment_type == "card") {
        Get.to(
          AppPaymentNewPage(
            PaymentUrl: responseModel.data["data"],
            FailedPaymentUrl: "${ApiConfig.baseUrl}/appointments/rajhi-failed-callback",
            SuccessPaymentUrl: "${ApiConfig.baseUrl}/appointments/rajhi-success-callback",
            onFailed: () {
              AppDialogs.showToast(message: "خطاء في عمليه الدفع");

              Get.back();
              return;
            },
            onSuccess: () {
              clearText();
              Get.offAll(PaymentSuccessPage());
            },
          ),
        );
        return;
      }

      if (payment_type == "wallet" || payment_type == "free") {
        clearText();
        Get.offAll(PaymentSuccessPage());
        authController.getProfile();
      }

      if (payment_type == "wallet_card") {
        Get.to(
          AppPaymentNewPage(
            PaymentUrl: responseModel.data["data"],
            FailedPaymentUrl: "${ApiConfig.baseUrl}/appointments/rajhi-failed-callback",
            SuccessPaymentUrl: "${ApiConfig.baseUrl}/appointments/rajhi-success-callback",
            onFailed: () {
              AppDialogs.showToast(message: "خطاء في عمليه الدفع");
              Get.back();
              return;
            },
            onSuccess: () {
              clearText();
              Get.offAll(PaymentSuccessPage());
            },
          ),
        );

        return;
      }

      return;
    }

    AppDialogs.showToast(message: responseModel.data["message"]);
  }

  void clearText() {
    service = "";
    selectBranch = "";
    selectDoctor = "";
    selectData = "";
    selectTime = "";
    selectNote = "";
  }
}
