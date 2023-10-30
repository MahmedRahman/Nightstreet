import 'package:get/get.dart';
import 'package:krzv2/app/modules/appointment/views/appointment_booking_view.dart';
import 'package:krzv2/app/modules/appointment/views/appointment_choose_a_doctor_view.dart';
import 'package:krzv2/app/modules/appointment/views/payment_appointment_view.dart';
import 'package:krzv2/app/modules/payment_bank/payment_page.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/web_serives/api_constant.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class AppointmentController extends GetxController {
  var selectBranch;
  var selectDoctor;
  String? selectData;
  String? selectTime;
  String? selectNote;

  var service;
  RxList AppointmentDataList = [].obs;

  void branchOfferDoctors() async {
    ResponseModel responseModel = await WebServices().getBranchOfferDoctors(
      branchId: selectBranch["id"],
      offerId: service["id"],
    );

    if (responseModel.data["success"]) {
      if (responseModel.data["data"]["data"].length == 0) {
        Get.to(
          AppointmentBookingView(
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

  void getAvailableOfferTimes() async {
    ResponseModel responseModel;

    print(selectDoctor);

    responseModel = await WebServices().getAvailableOfferTimes(
      offerId: service["id"],
      branchId: selectBranch["id"],
      doctorId: selectDoctor["id"],
      dateTime: selectData.toString(),
    );
    print("selectDoctor");
    if (responseModel.data["success"]) {
      AppointmentDataList.value = responseModel.data["data"];
      update();
    } else {
      AppointmentDataList.value = [];
      update();
    }
  }

  void bookAppointment({
    required String payment_type,
  }) async {
    ResponseModel responseModel = await WebServices().bookAppointment(
      payment_type: payment_type,
      offer_id: service["id"],
      branch_id: selectBranch["id"],
      doctor_id: selectDoctor["id"],
      date_time: selectData.toString(),
      time: selectTime.toString(),
      notes: selectNote.toString(),
    );
    service = "";
    selectBranch = "";
    selectDoctor = "";
    selectData = "";
    selectTime = "";
    selectNote = "";

    if (responseModel.data["success"]) {
      // AppDialogs.showToast(message: responseModel.data["data"]);

      if (payment_type == "card") {
        Get.to(
          AppPaymentPage(
            PaymentUrl: responseModel.data["data"],
            FailedPaymentUrl: "${ApiConstant.baseUrl}/appointments/rajhi-failed-callback",
            SuccessPaymentUrl: "${ApiConstant.baseUrl}/appointments/rajhi-success-callback",
          ),
        );
      }

      return;
    }

    AppDialogs.showToast(message: responseModel.data["message"]);
  }
}
