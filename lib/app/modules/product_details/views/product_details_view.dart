import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/product_details/controllers/similar_product_controller.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/counter_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/favorite_icon_view.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/component/views/image_swpier_view.dart';
import 'package:krzv2/component/views/on_product_loading_view.dart';
import 'package:krzv2/component/views/price_with_discount_view.dart';
import 'package:krzv2/component/views/product_brand_image_view.dart';
import 'package:krzv2/component/views/product_cash_back_view.dart';
import 'package:krzv2/component/views/product_color_selector_view.dart';
import 'package:krzv2/component/views/product_non_refundable_view.dart';
import 'package:krzv2/component/views/product_reviews_view.dart';
import 'package:krzv2/component/views/products_hotizontal_list_view.dart';
import 'package:krzv2/component/views/rating_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/share_icon_view.dart';
import 'package:krzv2/component/views/tabs/base_switch_3_tap.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  ProductDetailsView({Key? key}) : super(key: key);
  final similarProductController = Get.put(SimilarProductController());
  final controller = Get.put(ProductDetailsController());
  void customInit() {
    // Get.put(SimilarProductController());
    controller.fetchProductDetails(productId: Get.arguments as String);
  }

  @override
  Widget build(BuildContext context) {
    customInit();
    return controller.obx(
      (product) => buildBody(product),
      onLoading: OnProductLoadingView(),
      onError: (String? error) => Center(
        child: Text(
          error.toString(),
        ),
      ),
    );
  }

  BaseScaffold buildBody(ProductModel? product) {
    final similarProductController = Get.find<SimilarProductController>();
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'تفاصيل المنتج',
        actions: [
          CustomIconButton(
            onTap: () => Get.toNamed(Routes.SHOPPINT_CART),
            iconPath: AppSvgAssets.cartIcon,
            count: 2,
          ),
          CustomIconButton(
            onTap: () {},
            iconPath: AppSvgAssets.notificationIcon,
            count: 0,
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          AppSpacers.height12,
          ImageSwpierView(
            images: product!.images.map((e) => e.image).toList(),
          ),
          AppSpacers.height10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductBrandImageView(
                imageUrl: product.brand.image,
              ),
              Row(
                children: [
                  FavoriteIconView(
                    onFavoriteTapped: () {
                      final favCon = Get.put<ProductFavoriteController>(
                        ProductFavoriteController(),
                      );
                      product.isFavorite = !product.isFavorite;

                      favCon.addRemoveProductFromFavorite(
                        productId: product.id,
                        onError: () {
                          product.isFavorite = !product.isFavorite;
                        },
                      );

                      controller.update();
                    },
                    isFavorite: product.isFavorite,
                  ),
                  AppSpacers.width10,
                  ShareIconView(
                    onShareTapped: () {},
                  ),
                ],
              ),
            ],
          ),
          AppSpacers.height5,
          Divider(),
          Text(
            product.name,
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.blackColor,
              letterSpacing: 0.020799999237060548,
              height: 2.19,
            ),
            textAlign: TextAlign.right,
          ),
          AppSpacers.height16,
          Row(
            children: [
              PriceWithDiscountView(
                price: product.price.toString(),
                hasDiscount: product.oldPrice.toString() != '',
                oldPrice: product.oldPrice.toString(),
              ),
              AppSpacers.width10,
              RatingBarView(
                initRating: product.totalRateCount,
                totalRate: product.totalRateAvg,
                ignoreGestures: true,
              ),
            ],
          ),
          AppSpacers.height16,
          ProductCashBackView(cashBackValue: product.cashback),
          AppSpacers.height10,
          ProductColorSelectorView(
            onChanged: (String colorCode) {},
            variants: product.variants,
          ),
          AppSpacers.height12,
          ProductNonRefundableView(),
          AppSpacers.height5,
          Divider(),
          AppSpacers.height12,
          SizedBox(
            height: 400,
            child: Column(
              children: [
                BaseSwitch3Tap(
                  title1: 'وصف المنتج',
                  title2: 'طريقة الاستعمال',
                  title3: 'التقييمات',
                  Widget1: SingleChildScrollView(
                    child: Html(
                      data: product.desc,
                    ),
                  ),
                  Widget2: SingleChildScrollView(
                    child: Html(
                      data: product.usage,
                    ),
                  ),
                  Widget3: ProductReviewsView(),
                ),
              ],
            ),
          ),
          AppSpacers.height16,
          Divider(),
          AppSpacers.height16,
          similarProductController.obx(
            (products) => ProductsHotizontalListView.similarproducts(
              productsList: products ?? [],
              onShowMoreTapped: () {},
            ),
            onLoading: ProductsHotizontalListView.similarproducts(
              productsList: [
                ProductModel.dummyProduct,
              ],
              onShowMoreTapped: () {},
            ).shimmer(),
            onEmpty: SizedBox(),
          ),
          AppSpacers.height50,
        ],
      ),
      bottomBarHeight: 163,
      bottomNavigationBar: bottomNavigationBar(controller),
    );
  }

  Padding bottomNavigationBar(
    ProductDetailsController controller,
  ) {
    return Padding(
      padding: AppDimension.appPadding + EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => CounterView(
                width: 135,
                height: 53,
                borderRadius: 10,
                initValue: controller.productCount.value,
                onDecrementTapped: controller.decrement,
                onIncrementTapped: controller.increment,
              ),
            ),
          ),
          AppSpacers.width10,
          Expanded(
            flex: 2,
            child: CustomBtnCompenent.main(
              iconPath: AppSvgAssets.cartIcon,
              text: "إضافة إلى سلة الشراء",
              onTap: () => Get.toNamed(Routes.SHOPPINT_CART),
            ),
          ),
        ],
      ),
    );
  }
}
