import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ComplaintDetailsController extends GetxController with StateMixin {
  ScrollController? scrollController;
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    await getComplaintsDetails(complaintID: Get.arguments.toString());
    super.onReady();
  }

  Future getComplaintsDetails({required String complaintID}) async {
    change([], status: RxStatus.loading());
    ResponseModel responseModel =
        await WebServices().getComplaintsDetails(complaintID: complaintID);

    if (responseModel.data["success"]) {
      change(responseModel.data["data"], status: RxStatus.success());
      await Future.delayed(Duration(microseconds: 100));
      // scrollController!.jumpTo(scrollController!.position.maxScrollExtent);

      return;
    }

    if (responseModel.data["success"] == false) {
      change([], status: RxStatus.error(responseModel.data["message"]));
      return;
    }
  }

  Future SendComplaints({
    required String message,
    required String complaintID,
  }) async {
    change([], status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().setComplaints(
      complaintID: "$complaintID",
      message: "$message",
    );

    if (responseModel.data["success"]) {
      // change(responseModel.data["data"], status: RxStatus.success());
      // return;
      await getComplaintsDetails(complaintID: complaintID);
      return;
    }

    if (responseModel.data["success"] == false) {
      change([], status: RxStatus.error(responseModel.data["message"]));
      return;
    }
  }
}
