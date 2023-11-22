import 'package:get/get.dart';

import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class HomePageDummySliderSettingController extends GetxController with StateMixin<List> {
  @override
  void onInit() {
    getHomesSlider();
    // TODO: implement onInit
    super.onInit();
  }

  void getHomesSlider() async {
    ResponseModel responseModel = await WebServices().getHomesSliderSetting();
    if (responseModel.data["success"]) {
      change(responseModel.data["data"], status: RxStatus.success());
      return;
    }

    change(null, status: RxStatus.error());
  }
}
