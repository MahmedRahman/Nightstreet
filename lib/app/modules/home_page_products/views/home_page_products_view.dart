import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/app/modules/favorite/controllers/market_favorite_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_product_categories_controller.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_exclusive_offers_product_controller.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_most_seller_product_controller.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_products_slider_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/app/modules/store/view/store_view.dart';
import 'package:krzv2/component/paginated_list_view.dart';
import 'package:krzv2/component/views/app_bar_search_view.dart';
import 'package:krzv2/component/views/cards/market_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/home_categories_list_view.dart';
import 'package:krzv2/component/views/notification_icon_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/market_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';
import '../controllers/home_page_products_controller.dart';

class MarketController extends GetxController with StateMixin<List> {
  final pagingController =
      PagingController<int, MarketModel>(firstPageKey: 1).obs;
  RxString? categoryId = ''.obs;
  @override
  void onInit() {
    pageListener();
    super.onInit();
  }

  void pageListener() {
    pagingController.value.addPageRequestListener((pageKey) {
      currentPage = pageKey;
      getMarket();
    });
  }

  Future getMarket() async {
    ResponseModel responseModel = await WebServices().getMarket(
      categoryId: categoryId?.value,
      page: currentPage,
    );

    print(responseModel.data["success"].toString());
    if (responseModel.data["success"]) {
      try {
        final newItems = List<MarketModel>.from(
          responseModel.data['data']['data']
              .map((item) => MarketModel.fromMap(item)),
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
      } catch (e, st) {
        print('market => error $e');
        print('market => st $st');
      }
    }
    change(null, status: RxStatus.error());
    return;
  }

  int currentPage = 1;
}

class HomePageProductsView extends GetView<HomePageProductsController> {
  HomePageProductsView({Key? key}) : super(key: key);
  final productCategoriesController = Get.put(ProductCategoriesController());

  final marketController = Get.find<MarketController>();

  final authController = Get.find<AuthenticationController>();
  final sliderController = Get.find<HomePageProductSliderController>();
  final mostSelleerProductController = Get.put(MostSelleerProductController());
  final cartController = Get.find<ShoppingCartController>();
  final exclusiveOffersProductController =
      Get.put(ExclusiveOffersProductController());
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      onRefresh: () async => marketController.pagingController.refresh(),
      appBar: AppBarSerechView(
        placeHolder: 'ما الذي تريد البحث عنه ؟',
        actions: [
          if (authController.isLoggedIn || authController.isGuestUser)
            ShoppingCartIconView(),
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
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacers.height10,
            sliderController.obx(
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
            AppSpacers.height12,
            Text(
              "المتاجر",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
            AppSpacers.height12,
            productCategoriesController.obx(
              (categoriesList) {
                return HomeCategoriesListView(
                  categoriesList: categoriesList,
                  onCategoryTapped: (int categoryId) async {
                    marketController.pagingController.value =
                        PagingController(firstPageKey: 1);

                    marketController.categoryId!.value = categoryId.toString();

                    marketController.pageListener();
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
            AppSpacers.height12,
            Expanded(
              child: Obx(
                () => PaginatedListView<MarketModel>(
                  controller: marketController.pagingController.value,
                  firstLoadingIndicator: Column(
                    children: [
                      MarketCardView.dummy().paddingOnly(bottom: 10).shimmer(),
                      MarketCardView.dummy().shimmer(),
                    ],
                  ),
                  itemBuilder: itemBuilder,
                  onEmpty: AppPageEmpty.noMarketFound(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(_, MarketModel market, __) {
    return GetBuilder<MarketFavoriteController>(
      init: MarketFavoriteController(),
      builder: (favController) {
        return MarketCardView(
          imageUrl: market.image,
          name: market.name,
          desc: market.desc,
          onFavoriteTapped: () {
            if (Get.find<AuthenticationController>().isLoggedIn == false) {
              return AppDialogs.showToast(
                message: 'الرجاء تسجيل الدخول',
              );
            }

            favController.addRemoveMarketFromFavorite(
              branchId: market.id,
            );
          },
          onTapped: () {
            Get.to(
              MarketPage(
                {
                  "id": market.id,
                  "image": market.image,
                  "name": market.name,
                  "desc": market.desc,
                  "total_rate_avg": market.rate,
                  "total_rate_count": market.totalRate,
                },
              ),
            );
          },
          isFavorite: favController.marketsFavoriteIds.value!.contains(
            market.id,
          ),
          rate: market.rate.toString(),
          totalRate: market.totalRate.toString(),
        ).paddingOnly(
          bottom: 10,
        );
      },
    );
  }
}
