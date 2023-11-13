import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/appointment_model.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class EditAppointmentController extends GetxController {
  AppointmentModel? appointment;
  String? selectData = "";
  String? selectTime = "";
  String? selectNote = "";

  RxString selectTimeUI = "".obs;
  RxList AppointmentDataList = [].obs;

  RxString selectDateUI = ''.obs;

  @override
  void onInit() {
    appointment = Get.arguments;

    print("Money ${appointment!.date_time.toString()}");

    selectData = appointment!.date_time.toString();
    selectTime = appointment!.time_format.toString();
    selectTimeUI.value = appointment!.time_format.toString();
    selectNote = appointment!.notes.toString();
    //selectDateUI.value = appointment["date_time"];
    getAvailableOfferTimes();
    // print(selectData.toString().split(" ")[0]);
    // print(DateTime.now().toString());
    super.onInit();
  }

  void getAvailableOfferTimes() async {
    ResponseModel responseModel;
    responseModel = await WebServices().getAvailableOfferTimes(
      offerId: appointment!.offer.id,
      branchId: appointment!.branchId!,
      doctorId: appointment!.doctorId,
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

  void editAppointments({
    required String appointmentID,
    required String dateTime,
    required String time,
    required String notes,
  }) async {
    ResponseModel responseModel;
    responseModel = await WebServices().updateAppointment(
      appointmentID: appointmentID,
      time: time,
      dateTime: dateTime,
      notes: notes,
    );

    if (responseModel.data["success"]) {
      AppDialogs.showToast(message: responseModel.data["message"]);

      Future.delayed(Duration(seconds: 1)).then((value) {
        Get.back(result: "Done");
      });

      return;
    } else {
      AppDialogs.showToast(message: responseModel.data["message"]);
    }
  }
}
