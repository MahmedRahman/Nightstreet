

// class HomePageDummySliderSettingController extends GetxController with StateMixin<List> {
//   @override
//   void onInit() {
//     getHomesSlider();
//     // TODO: implement onInit
//     super.onInit();
//   }

//   void getHomesSlider() async {
//     ResponseModel responseModel = await WebServices().getHomesSliderSetting();
//     if (responseModel.data["success"]) {
//       change(responseModel.data["data"], status: RxStatus.success());
//       return;
//     }

//     change(null, status: RxStatus.error());
//   }
// }
