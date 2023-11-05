import 'package:get/get.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

List dataCity = [];

class DeliveryAddressesController extends GetxController with StateMixin<List> {
  final addresses = Rx<List<dynamic>?>([]);
  @override
  void onInit() {
    getAddress();
    getCite();
    super.onInit();
  }

  void getAddress() async {
    change(null, status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getAddresses();
    if (responseModel.data["success"]) {
      addresses.value?.clear();
      if ((responseModel.data["data"] as List).length == 0) {
        change([], status: RxStatus.empty());
        return;
      }

      change(responseModel.data["data"], status: RxStatus.success());
      addresses.value?.addAll(responseModel.data["data"] as List);
      return;
    }
    change(null, status: RxStatus.error());
  }

  Future getCite() async {
    if (dataCity.length != 0) {
      return;
    }
    ResponseModel responseModel = await WebServices().getCities();
    if (responseModel.data["success"]) {
      dataCity = responseModel.data["data"];
    }
  }

  void activationAddresses({
    required String id,
  }) async {
    ResponseModel responseModel = await WebServices().activationAddresses(
      id: id,
    );
//change(null, status: RxStatus.lo());
    if (responseModel.data["success"]) {
      getAddress();
      //change(null, status: RxStatus.success());
      return;
    }

    change(null, status: RxStatus.error());
  }
}
