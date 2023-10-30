import 'package:get/get.dart';
import 'package:krzv2/models/appointment_model.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class EditAppointmentController extends GetxController {
  AppointmentModel? appointment;
  RxList AppointmentDataList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    appointment = Get.arguments;
    getAvailableOfferTimes();
    super.onInit();
  }

  void getAvailableOfferTimes() async {
    ResponseModel responseModel;

    //print(selectDoctor);

    responseModel = await WebServices().getAvailableOfferTimes(
      offerId: appointment!.id,
      branchId: appointment!.branchId!,
      doctorId: int.parse(appointment!.doctorId),
      dateTime: appointment!.datetime,
    );
    // print("selectDoctor");
    if (responseModel.data["success"]) {
      AppointmentDataList.value = responseModel.data["data"];
      update();
    } else {
      AppointmentDataList.value = [];
      update();
    }
  }
}
