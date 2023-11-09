import 'package:get/get.dart';
import 'package:krzv2/models/slider_model.dart';
import 'package:krzv2/utils/app_enums.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class HomePageProductSliderController extends GetxController
    with StateMixin<List<SliderModel>> {
  @override
  void onInit() {
    getHomePageProductSlider();
    super.onInit();
  }

  void getHomePageProductSlider() async {
    change(null, status: RxStatus.loading());
    ResponseModel responseModel =
        await WebServices().getSliderSetting(type: SliderEnum.product.name);

    if (responseModel.data["success"]) {
      final List<SliderModel> sliderList = List<SliderModel>.from(
        responseModel.data['data']
            .map((category) => SliderModel.fromJson(category)),
      );

      if (sliderList.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(sliderList, status: RxStatus.success());
      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }
}
