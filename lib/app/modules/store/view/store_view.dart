import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/market_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_product_categories_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/market_categories_controller.dart';
import 'package:krzv2/app/modules/home_page_products/views/home_page_products_view.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/views/cards/market_card_view.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/home_categories_list_view.dart';
import 'package:krzv2/component/views/notification_icon_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class MarketPageController extends GetxController
    with StateMixin<List>, ScrollMixin {
  var MarketId;
  final categoriesList = Rx<List<dynamic>?>([]);
  @override
  void onInit() {
    currentPage = 1;
    // TODO: implement onInit
    super.onInit();
  }

  List productList = [];
  Future getProductByMarketId(String MarketId, {String? categoryId}) async {
    if (currentPage == 1) change(null, status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().getProductsByMarketId(
      id: MarketId.toString(),
      page: currentPage.toString(),
      categoryId: categoryId,
    );
    print(responseModel.data["success"].toString());
    if (responseModel.data["success"]) {
      if (responseModel.data["data"]["data"].isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }
      productList.addAll(responseModel.data["data"]["data"]);

      change(productList, status: RxStatus.loadingMore());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;

      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }

  Future getMarketCategories(String MarketId) async {
    ResponseModel responseModel = await WebServices().getCategoriesByMarketId(
      marketId: MarketId.toString(),
    );

    if (responseModel.data["success"]) {
      if (responseModel.data["data"]["data"].isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }
      productList.addAll(responseModel.data["data"]["data"]);

      change(productList, status: RxStatus.loadingMore());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;

      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }

  int currentPage = 1;
  bool isPagination = false;
  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;

    currentPage++;

// AppDialog.showLoading().then (() asysn{
//   await getProductByMarketId(MarketId);
// },onFinsh:(){
//    Get.back();
// });

    Get.dialog(
      const Center(
        child: SpinKitCircle(
          color: AppColors.mainColor,
          size: 70,
        ),
      ),
    );

    await getProductByMarketId(MarketId);

    Get.back();
  }

  @override
  Future<void> onTopScroll() async {}
}

class MarketPage extends GetView<MarketPageController> {
  final authController = Get.find<AuthenticationController>();
  MarketPageController controller = Get.put(MarketPageController());
  final marketCategoriesController = Get.put(MarketCategoriesController());

  var data;

  MarketPage(data) {
    this.data = data;
    print("object");
    controller.MarketId = data["id"].toString();
    controller.getProductByMarketId(data["id"].toString());
    marketCategoriesController.getMarketCategories(
      marketId: data["id"].toString(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: "متجر",
        actions: [
          if (authController.isLoggedIn || authController.isGuestUser)
            ShoppingCartIconView(),
          if (authController.isLoggedIn) NotificationIconView(),
          AppSpacers.width20,
        ],
      ),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<MarketFavoriteController>(
              init: MarketFavoriteController(),
              initState: (_) {},
              builder: (favController) {
                return MarketCardView(
                  imageUrl: data["image"].toString(),
                  name: data["name"].toString(),
                  desc: data["desc"].toString(),
                  displayFullDesc: true,
                  isFavorite: favController.marketsFavoriteIds.value!.contains(
                    data["id"],
                  ),
                  onFavoriteTapped: () {
                    if (Get.find<AuthenticationController>().isLoggedIn ==
                        false) {
                      return AppDialogs.showToast(
                          message: 'الرجاء تسجيل الدخول');
                    }

                    favController.addRemoveMarketFromFavorite(
                      branchId: data["id"],
                    );
                  },
                  onTapped: () {},
                ).paddingOnly(bottom: 10);
              },
            ),
            AppSpacers.height16,
            marketCategoriesController.obx(
              (categoriesList) {
                return HomeCategoriesListView(
                  categoriesList: categoriesList,
                  onCategoryTapped: (int categoryId) async {
                    controller.currentPage = 1;
                    controller.isPagination = false;
                    controller.productList = [];
                    controller.getProductByMarketId(
                      data["id"].toString(),
                      categoryId: categoryId.toString(),
                    );
                  },
                );
              },
              onLoading: HomeCategoriesListView(
                categoriesList: [],
                onCategoryTapped: (int categoryId) {
                  Get.toNamed(Routes.PRODUCTS_LIST);
                },
              ).shimmer(),
              onEmpty: Center(
                child: Text('لا توجد اقسام'),
              ),
            ),
            AppSpacers.height16,
            Text(
              "المنتجات",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
            AppSpacers.height16,
            Expanded(
              child: controller.obx(
                (data) {
                  print("object");
                  return productsList(
                    products: data!,
                    controller: controller,
                  );
                },
                onEmpty: AppPageEmpty.productSearchP(),
                onLoading: GridView.builder(
                  itemCount: 4,
                  padding: EdgeInsets.only(top: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight) / .35,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (_, index) {
                    return ProductCardView.dummy().shimmer();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final double itemHeight = (Get.height - kToolbarHeight - 24) / 1;
final double itemWidth = Get.width / 2;

GridView productsList({
  required List products,
  controller,
}) {
  return GridView.builder(
    itemCount: products.length,
    controller: controller.scroll,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight) / .35,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (_, index) {
      final product = products[index];
      return GetBuilder<ProductFavoriteController>(
        init: ProductFavoriteController(),
        builder: (controller) {
          return ProductCardView(
            imageUrl: product["image"].toString(),
            isAvailable: product["quantity"] > 1,
            name: product["name"].toString(),
            hasDiscount: product["old_price"] != 0,
            price: product["price"].toString(),
            oldPrice: product["old_price"].toString(),
            onAddToCartTapped: () {
              if (product["variants"].isNotEmpty) {
                AppDialogs.showToast(
                  message: 'هذا المنتج يحتوى على الوان يجب اختيار اللون',
                );
                Get.toNamed(
                  Routes.PRODUCT_DETAILS,
                  arguments: product["id"].toString(),
                );

                return;
              }
              final isGuest = Get.find<AuthenticationController>().isGuestUser;
              if (isGuest) {
                Get.find<ShoppingCartController>().addToGuestCart(
                  productId: product["id"].toString(),
                  quantity: '1',
                  isNew: true,
                );

                return;
              }
              Get.find<ShoppingCartController>().addToCart(
                productId: product["id"].toString(),
                quantity: '1',
                isNew: true,
              );
            },
            onFavoriteTapped: () {
              if (Get.find<AuthenticationController>().isLoggedIn == false) {
                return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
              }
              final favCon = Get.put<ProductFavoriteController>(
                ProductFavoriteController(),
              );

              favCon.addRemoveProductFromFavorite(
                productId: product["id"],
              );
            },
            isFavorite: controller.productFavoriteIds.value!.contains(
              product["id"],
            ),
            onTap: () async {
              Get.toNamed(
                Routes.PRODUCT_DETAILS,
                arguments: product["id"].toString(),
              );
            },
          );
        },
      );
    },
  );
}
