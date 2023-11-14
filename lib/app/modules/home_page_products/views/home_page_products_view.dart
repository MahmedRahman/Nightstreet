import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_product_categories_controller.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_exclusive_offers_product_controller.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_most_seller_product_controller.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_products_slider_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/app/modules/store/view/store_view.dart';
import 'package:krzv2/component/views/app_bar_search_view.dart';
import 'package:krzv2/component/views/cards/market_card_view.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/home_categories_list_view.dart';
import 'package:krzv2/component/views/notification_icon_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';
import '../controllers/home_page_products_controller.dart';

class MarketController extends GetxController with StateMixin<List> {
  @override
  void onInit() {
    getMarket();
    super.onInit();
  }

  void getMarket() async {
    ResponseModel responseModel = await WebServices().getMarket();

    print(responseModel.data["success"].toString());
    if (responseModel.data["success"]) {
      change(responseModel.data["data"]["data"], status: RxStatus.success());
      return;
    }
    change(null, status: RxStatus.error());
    return;
  }
}

class HomePageProductsView extends GetView<HomePageProductsController> {
  HomePageProductsView({Key? key}) : super(key: key);
  final productCategoriesController = Get.put(ProductCategoriesController());

  final marketController = Get.find<MarketController>();

  final authController = Get.find<AuthenticationController>();
  final sliderController = Get.find<HomePageProductSliderController>();
  final mostSelleerProductController = Get.put(MostSelleerProductController());
  final cartController = Get.find<ShoppingCartController>();
  final exclusiveOffersProductController = Get.put(ExclusiveOffersProductController());
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBarSerechView(
        placeHolder: 'ما الذي تريد البحث عنه ؟',
        actions: [
          if (authController.isLoggedIn || authController.isGuestUser) ShoppingCartIconView(),
          if (authController.isLoggedIn) NotificationIconView(),
          AppSpacers.width20,
        ],
        onTap: () async {
          final shoudRefresh = await Get.toNamed(Routes.PRODUCT_SEARCH);
          if (shoudRefresh != null) {
            mostSelleerProductController.onInit();
            exclusiveOffersProductController.onInit();
          }
        },
      ),
      body: Column(
        children: [
          AppSpacers.height10,
          Padding(
            padding: AppDimension.appPadding,
            child: sliderController.obx(
              (slidersList) {
                return SliderView(
                  images: slidersList!.map((slider) => slider.image).toList(),
                );
              },
              onLoading: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black,
                ),
              ).shimmer(),
            ),
          ),
          AppSpacers.height16,
          productCategoriesController.obx(
            (categoriesList) {
              return HomeCategoriesListView(
                categoriesList: categoriesList,
                onCategoryTapped: (int categoryId) async {
                  final shoudRefresh = await Get.toNamed(
                    Routes.PRODUCTS_LIST,
                    arguments: categoryId.toString(),
                  );
                  if (shoudRefresh != null) {
                    mostSelleerProductController.onInit();
                    exclusiveOffersProductController.onInit();
                  }
                },
              );
            },
            onLoading: HomeCategoriesListView(
              categoriesList: [],
              onCategoryTapped: (int categoryId) {
                Get.toNamed(Routes.PRODUCTS_LIST);
              },
            ).shimmer(),
          ),
          AppSpacers.height16,
          Padding(
            padding: AppDimension.appPadding,
            child: Row(
              children: [
                Text("المتاجر"),
                Spacer(),
                Text("عرض الكل"),
              ],
            ),
          ),
          AppSpacers.height16,
          Expanded(
            child: marketController.obx(
              (data) {
                return ListView.builder(
                  padding: AppDimension.appPadding,
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return MarketCardView(
                      imageUrl: data[index]["image"].toString(),
                      name: data[index]["name"].toString(),
                      onFavoriteTapped: () {},
                      onTapped: () {
                        Get.to(MarketPage(data[index]));
                      },
                      isFavorite: false,
                    ).paddingOnly(
                      bottom: 10,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
