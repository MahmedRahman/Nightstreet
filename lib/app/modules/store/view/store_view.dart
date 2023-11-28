import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/app/modules/favorite/controllers/market_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/market_categories_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/paginated_grid_view.dart';
import 'package:krzv2/component/views/cards/market_card_view.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/home_categories_list_view.dart';
import 'package:krzv2/component/views/notification_icon_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class MarketPageController extends GetxController with StateMixin<List> {
  RxString marketId = ''.obs;
  RxString categoryId = ''.obs;
  final categoriesList = Rx<List<dynamic>?>([]);

  final pagingController =
      PagingController<int, ProductModel>(firstPageKey: 1).obs;
  int currentPage = 1;
  @override
  void onInit() {
    pageListener();
    super.onInit();
  }

  void pageListener() {
    pagingController.value.addPageRequestListener(
      (pageKey) {
        currentPage = pageKey;
        getProductByMarketId(
          MarketId: marketId.value,
          page: currentPage,
        );
      },
    );
  }

  Future getProductByMarketId({
    required String MarketId,
    required int page,
  }) async {
    ResponseModel responseModel = await WebServices().getProductsByMarketId(
      id: MarketId.toString(),
      page: currentPage.toString(),
      categoryId: categoryId.value,
    );

    if (responseModel.data["success"]) {
      if ((responseModel.data["data"]["data"] as List).isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      final newItems = List<ProductModel>.from(
        responseModel.data['data']['data']
            .map((item) => ProductModel.fromJson(item)),
      );
      final isPaginate =
          responseModel.data['data']['pagination']['is_pagination'] as bool;

      if (isPaginate == false) {
        pagingController.value.appendLastPage(newItems.toSet().toList());
      } else {
        final nextPageKey = currentPage + 1;
        pagingController.value
            .appendPage(newItems.toSet().toList(), nextPageKey);
      }
      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }
}

class MarketPage extends GetView<MarketPageController> {
  final authController = Get.find<AuthenticationController>();
  final MarketPageController controller = Get.put(MarketPageController());
  final marketCategoriesController = Get.put(MarketCategoriesController());

  var data;

  MarketPage(data) {
    this.data = data;

    controller.marketId.value = data["id"].toString();
    marketCategoriesController.getMarketCategories(
      marketId: data["id"].toString(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      onRefresh: () async {
        controller.pagingController.refresh();
      },
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
                  rate: data["total_rate_avg"].toString(),
                  totalRate: data["total_rate_count"].toString(),
                ).paddingOnly(bottom: 10);
              },
            ),
            AppSpacers.height12,
            Text(
              "المنتجات",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
            AppSpacers.height12,
            marketCategoriesController.obx(
              (categoriesList) {
                return HomeCategoriesListView(
                  categoriesList: categoriesList,
                  onCategoryTapped: (int categoryId) async {
                    controller.categoryId.value = categoryId.toString();

                    controller.pagingController.value =
                        PagingController(firstPageKey: 1);

                    controller.pageListener();
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
            AppSpacers.height12,
            Expanded(
              child: Obx(
                () => PaginatedGridView<ProductModel>(
                  controller: controller.pagingController.value,
                  firstLoadingIndicator: firstLoadingIndicator(),
                  itemBuilder: itemBuilder,
                  onEmpty: AppPageEmpty.productSearchPP(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container firstLoadingIndicator() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * .38,
            child: ProductCardView.dummy().shimmer().paddingOnly(bottom: 10),
          ),
          SizedBox(
            height: Get.height * .38,
            child: ProductCardView.dummy().shimmer().paddingOnly(bottom: 10),
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(_, ProductModel product, __) {
    return GetBuilder<ProductFavoriteController>(
      init: ProductFavoriteController(),
      builder: (controller) {
        return ProductCardView(
          imageUrl: product.image,
          isAvailable: product.quantity > 1,
          name: product.name,
          hasDiscount: product.oldPrice.toInt() != 0,
          price: product.price.toString(),
          oldPrice: product.oldPrice.toString(),
          onAddToCartTapped: () {
            if (product.variants.isNotEmpty) {
              AppDialogs.showToast(
                message: 'هذا المنتج يحتوى على الوان يجب اختيار اللون',
              );
              Get.toNamed(
                Routes.PRODUCT_DETAILS,
                arguments: product.id.toString(),
              );

              return;
            }
            final isGuest = Get.find<AuthenticationController>().isGuestUser;
            if (isGuest) {
              Get.find<ShoppingCartController>().addToGuestCart(
                productId: product.id.toString(),
                quantity: '1',
                isNew: true,
              );

              return;
            }
            Get.find<ShoppingCartController>().addToCart(
              productId: product.id.toString(),
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
              productId: product.id,
            );
          },
          isFavorite: controller.productFavoriteIds.value!.contains(
            product.id,
          ),
          onTap: () async {
            Get.toNamed(
              Routes.PRODUCT_DETAILS,
              arguments: product.id.toString(),
            );
          },
        );
      },
    );
  }
}
