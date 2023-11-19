import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_product_categories_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_recommended_product_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_service_categories.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_service_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_slider_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/home_app_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class HomePageView extends GetView {
  final cartController = Get.find<ShoppingCartController>();
  final sliderController = Get.put(HomePageSliderController());
  final servicesController = Get.put(HomePageServiceController());
  final serviceCategoriesController = Get.find<ServiceCategoriesController>();
  final productCategoriesController = Get.find<ProductCategoriesController>();
  final recommendedProductController = Get.put(RecommendedProductController());
  final bottomNavigationBarController = Get.put(MyBottomNavigationController());

  @override
  Widget build(BuildContext context) {
    final bottomBarController = Get.find<MyBottomNavigationController>();
    return BaseScaffold(
      appBar: HomeAppBarView(),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            SliderView.dyume(180),
            AppSpacers.height10,
            homeCard(
              title: 'العروض',
              onTap: () => bottomBarController.changePage(3),
            ),
            homeCard(
              title: 'المتاجر',
              onTap: () => bottomBarController.changePage(2),
            ),
            homeCard(
              title: 'العيادات',
              onTap: () => bottomBarController.changePage(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget homeCard({
    required String title,
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
              CashedNetworkImageView(
                  imageUrl:
                      "https://img.freepik.com/free-photo/natural-elements-spa-with-beauty-cream_23-2148199484.jpg?w=1800&t=st=1699884415~exp=1699885015~hmac=01db13cdce03a1e6130ccda36bdb23241e3abb37bc4377571c6fbea835be436e"),
              Positioned(
                bottom: 60,
                right: 22,
                child: Container(
                  alignment: Alignment(0.19, -0.09),
                  width: 69.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: const Color(0xFF7D3A5B),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Effra',
                      fontSize: 14.0,
                      color: Colors.white,
                      letterSpacing: 0.14,
                      height: 0.86,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
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
                        Text(
                          'خصومات تصل إلى',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: const Color(0xFF3B3B3B),
                            fontWeight: FontWeight.w500,
                            height: 1.36,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          width: 27,
                        ),
                        Text(
                          '30%',
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
