import 'package:get/get.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class HomePageController extends GetxController with StateMixin<List> {
  @override
  void onInit() {
    getHomePageView();
    super.onInit();
  }

//getHomeSection
  void getHomePageView() async {
    //setting/sections
    ResponseModel responseModel = await WebServices().getHomeSection();
    if (responseModel.data["success"]) {
      change(responseModel.data["data"], status: RxStatus.success());
      return;
    }

    change(null, status: RxStatus.error());
  }
}
