import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krzv2/models/appointment_model.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class EditAppointmentController extends GetxController {
  var appointment;
  String? selectData = "";
  String? selectTime = "";
  String? selectNote = "";

  RxString? selectTimeUI = "".obs;
  RxList AppointmentDataList = [].obs;

  @override
  void onInit() {
    appointment = Get.arguments;
    selectData = appointment["date_time"];
    selectTime = appointment["time_format"];
    selectNote = appointment["notes"];
    getAvailableOfferTimes();
    // print(selectData.toString().split(" ")[0]);
    // print(DateTime.now().toString());
    super.onInit();
  }

  void getAvailableOfferTimes() async {
    ResponseModel responseModel;
    print(GetUtils.isNullOrBlank(appointment["doctor"])!);
    responseModel = await WebServices().getAvailableOfferTimes(
      offerId: appointment["offer"]["id"],
      branchId: appointment["branch"]["id"],
      doctorId: GetUtils.isNullOrBlank(appointment["doctor"])! ? null : appointment["doctor"]["id"],
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
  }
}
