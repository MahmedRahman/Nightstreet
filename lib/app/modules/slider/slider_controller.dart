import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_launcuer.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';



String? KsliderPlace;

class HomePageDummySliderSettingController extends GetxController with StateMixin<List> {
  @override
  void onInit() {
    getHomesSlider();
    // TODO: implement onInit
    super.onInit();
  }

  void getHomesSlider() async {
    change(null, status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().getHomesSliderSetting(
      KsliderPlace.toString(),
    );
    if (responseModel.data["success"]) {
      change(responseModel.data["data"], status: RxStatus.success());
      return;
    }

    change(null, status: RxStatus.error());
  }
}

class AppSliderView extends GetView<HomePageDummySliderSettingController> {
  final bottomBarController = Get.find<MyBottomNavigationController>();

  AppSliderView({sliderPlace}) {
    KsliderPlace = sliderPlace;
    print("KsliderPlace ${KsliderPlace}");
    Get.put(HomePageDummySliderSettingController());
    controller.getHomesSlider();
  }

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (data) {
        if (data!.length == 0) {
          return SizedBox.shrink();
        }
        return SliderHomePageView(
          images: data,
          onSliderTap: (data) {
            print("Slider ${data.toString()}");

            if (data["redirect_type"] == "internal") {
              if (data["model_name"] == "clinics") {
                bottomBarController.changePage(1);
                return;
              }

              if (data["model_name"] == "markets") {
                bottomBarController.changePage(2);
                return;
              }

              if (data["model_name"] == "login") {
                //If User is Login just return
                //NoBackButton
                Get.toNamed(Routes.LOGIN);
                return;
              }

              if (data["model_name"] == "register") {
                //If User is Login just return
                //NoBackButton
                Get.toNamed(
                  Routes.REGISTER,
                  arguments: ["", Get.routing.previous],
                );
                return;
              }

              if (data["model_name"] == "services_offers") {
                bottomBarController.changePage(3);
                return;
              }

              if (data["model_name"] == "products_offers") {
                //RouteTab
                bottomBarController.changePage(3);
                return;
              }

              return;
            }

            if (data["redirect_type"] == "single_model") {
              if (data["model_type"] == "App\\Models\\Product") {
                Get.toNamed(
                  Routes.PRODUCT_DETAILS,
                  arguments: data["model_id"].toString(),
                );

                print("${data["model_id"]}");
                return;
              }

              if (data["model_type"] == "App\\Models\\Offer") {
                Get.toNamed(
                  Routes.SERVICE_DETAIL,
                  arguments: data["model_id"].toString(),
                );

                return;
              }

              if (data["model_type"] == "App\\Models\\Category") {
                //Router To Department
                bottomBarController.changePage(2);
                return;
              }

              if (data["model_type"] == "App\\Models\\MarketCategory") {
                //Router To Department
                bottomBarController.changePage(3);
                return;
              }

              if (data["model_type"] == "App\\Models\\Branch") {
                Get.toNamed(
                  Routes.CLINIC_INFO,
                  arguments: data["model_id"],
                );
                return;
              }

              if (data["model_type"] == "App\\Models\\Market") {
                print("${data["model_id"]}");
                //Router To Department

                return;
              }

              return;
            }

            if (data["redirect_type"] == "external") {
              urlLauncher(data["url"]);
              return;
            }
          },
        );
      },
      onEmpty: SizedBox.shrink(),
      onLoading: Container(
        height: 150,
        width: context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey,
        ),
      ).shimmer(),
    );
  }
}
