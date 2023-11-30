import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/home_page/controllers/Home%D9%80page_dummy_slider_setting_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_product_categories_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_recommended_product_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_service_categories.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_service_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_slider_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/home_app_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/extensions/widget.dart';

import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/app_version_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_launcuer.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class HomePageView extends GetView {
  HomePageView() {
    appVersion.getAppVersion().then(
      (value) async {
        final hasForceUpdate = await appVersion.showUpdateDialog();

        if (hasForceUpdate == true) AppDialogs.updateApp();
      },
    );
  }
  final cartController = Get.find<ShoppingCartController>();
  final sliderController = Get.put(HomePageSliderController());
  final servicesController = Get.put(HomePageServiceController());
  final serviceCategoriesController = Get.find<ServiceCategoriesController>();
  final productCategoriesController = Get.find<ProductCategoriesController>();
  final recommendedProductController = Get.put(RecommendedProductController());
  final bottomNavigationBarController = Get.put(MyBottomNavigationController());
  final homesSliderSettingController =
      Get.put(HomePageDummySliderSettingController());
  final appVersion = Get.find<AppVersionService>();

  final homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    final bottomBarController = Get.find<MyBottomNavigationController>();
    return BaseScaffold(
      appBar: HomeAppBarView(),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            homesSliderSettingController.obx(
              (data) {
                return SliderHomePageView(
                  images: data!,
                  onSliderTap: (data) {
                    print(data.toString());
                    if (data["redirect_type"] == "internal") {
                      if (data["model_name"] == "products") {
                        bottomBarController.changePage(2);
                        return;
                      }

                      if (data["model_name"] == "offers") {
                        bottomBarController.changePage(3);
                        return;
                      }

                      if (data["model_name"] == "clinits") {
                        bottomBarController.changePage(1);
                        return;
                      }

                      if (data["model_name"] == "markets") {
                        bottomBarController.changePage(2);
                        return;
                      }

                      return;
                    }

                    if (data["redirect_type"] == "single_model") {
                      if (data["model_name"] == "products") {
                        Get.toNamed(
                          Routes.PRODUCT_DETAILS,
                          arguments: data["model_id"].toString(),
                        );

                        print("${data["model_id"]}");
                        return;
                      }

                      if (data["model_name"] == "offers") {
                        Get.toNamed(
                          Routes.SERVICE_DETAIL,
                          arguments: data["model_id"].toString(),
                        );
                        print("${data["model_id"]}");

                        return;
                      }

                      return;
                    }

                    if (data["redirect_type"] == "external") {
                      urlLauncher(data["url"]);

                      return;
                    }

                    print(data);
                    print(data["type"].toString());
                  },
                );
              },
              onLoading: Container(
                height: 150,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
              ).shimmer(),
            ),
            AppSpacers.height10,
            homePageController.obx(
              (data) {
                return Expanded(
                  child: Column(
                    children: List.generate(
                      data!.length,
                      (index) {
                        return homeCard(
                          title: data[index]["name"].toString(),
                          subdata: (data[index]["content"].toString() == "null")
                              ? ""
                              : data[index]["content"].toString(),
                          imageUrl: data[index]["image"].toString(),
                          discountPercentage:
                              data[index]["discount_percentage"].toString(),
                          onTap: () {
                            if (data[index]["redirect_type"] == "offers") {
                              bottomBarController.changePage(3);

                              return;
                            }

                            if (data[index]["redirect_type"] == "clinics") {
                              bottomBarController.changePage(1);

                              return;
                            }

                            if (data[index]["redirect_type"] == "markets") {
                              bottomBarController.changePage(2);

                              return;
                            }

                            bottomBarController.changePage(0);
                          },
                        );
                      },
                    ),
                  ),
                );
              },
              onLoading: Column(
                children: [
                  Container(
                    height: 100,
                    width: context.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                  ).shimmer().paddingOnly(bottom: 10),
                  Container(
                    height: 100,
                    width: context.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                  ).shimmer().paddingOnly(bottom: 10),
                  Container(
                    height: 100,
                    width: context.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                  ).shimmer().paddingOnly(bottom: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget homeCard({
    required String title,
    required String subdata,
    required String imageUrl,
    required String discountPercentage,
    required Function() onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CashedNetworkImageView(imageUrl: imageUrl),
              Positioned(
                bottom: 60,
                right: 22,
                child: SizedBox(),
                // child: Container(
                //   alignment: Alignment(0.19, -0.09),
                //   width: 69.0,
                //   height: 28.0,
                //   decoration: BoxDecoration( //     borderRadius: BorderRadius.circular(3.0),
                //     color: const Color(0xFF7D3A5B),
                //   ),
                //   child: Text(
                //     title,
                //     style: TextStyle(
                //       fontFamily: 'Effra',
                //       fontSize: 14.0,
                //       color: Colors.white,
                //       letterSpacing: 0.14,
                //       height: 0.86,
                //     ),
                //     textAlign: TextAlign.right,
                //   ),
                // ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.81),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: Get.width * .3,
                          ),
                          child: Text(
                            '${subdata.toString()}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: const Color(0xFF3B3B3B),
                              fontWeight: FontWeight.w500,
                              height: 1.36,
                            ),
                            textAlign: TextAlign.right,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          width: 27,
                        ),
                        (discountPercentage == "0")
                            ? Text("")
                            : Text(
                                '${discountPercentage}%',
                                style: TextStyle(
                                  fontFamily: 'Effra',
                                  color: const Color(0xFF7D3A5B),
                                  fontWeight: FontWeight.w500,
                                  height: 1.36,
                                ),
                                textAlign: TextAlign.right,
                              ),
                        Spacer(),
                        Text(
                          'تسوق الآن',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500,
                            height: 1.36,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(AppSvgAssets.homeArrowIcon),
                        SvgPicture.asset(AppSvgAssets.homeArrowIcon),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
