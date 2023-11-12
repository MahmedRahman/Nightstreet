// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
// import 'package:krzv2/app/modules/home_page/controllers/home_page_product_categories_controller.dart';
// import 'package:krzv2/app/modules/home_page_products/controllers/home_page_products_slider_controller.dart';
// import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
// import 'package:krzv2/component/views/cards/product_card_view.dart';
// import 'package:krzv2/component/views/custom_dialogs.dart';
// import 'package:krzv2/component/views/home_categories_list_view.dart';
// import 'package:krzv2/component/views/slider_view.dart';
// import 'package:krzv2/extensions/widget.dart';
// import 'package:krzv2/routes/app_pages.dart';
// import 'package:krzv2/services/auth_service.dart';
// import 'package:krzv2/utils/app_spacers.dart';
// import 'package:krzv2/web_serives/model/api_response_model.dart';
// import 'package:krzv2/web_serives/web_serives.dart';

// RxInt KProductHighestPrice = 0.obs;

// class OfferProductController extends GetxController with StateMixin<List> {
//   @override
//   void onInit() {
//     getOffersProduct();
//     super.onInit();
//   }

//   void getOffersProduct() async {
//     ResponseModel responseModel = await WebServices().getOffersProduct();
//     if (responseModel.data["success"]) {
//       if ((responseModel.data["data"]["data"] as List).length == 0) {
//         change(null, status: RxStatus.empty());
//         return;
//       }

//       KProductHighestPrice.value = responseModel.data["data"]["highest_price"];

//       change(responseModel.data["data"]["data"], status: RxStatus.success());
//       return;
//     }

//     change(null, status: RxStatus.error());
//   }
// }

// class OfferProductView extends GetView<OfferProductController> {
//   OfferProductView({Key? key}) : super(key: key);
//   final controller = Get.put(OfferProductController());
//   final cartController = Get.find<ShoppingCartController>();
//   final sliderController = Get.find<HomePageProductSliderController>();
//   final productCategoriesController = Get.find<ProductCategoriesController>();

//   @override
//   Widget build(BuildContext context) {
//     final double itemHeight = (Get.height - kToolbarHeight - 24) / 1;
//     final double itemWidth = Get.width / 2;

//     return Scaffold(
//         body: Column(
//       children: [
//         sliderController.obx(
//           (slidersList) {
//             return SliderView(
//               images: slidersList!.map((slider) => slider.image).toList(),
//             );
//           },
//           onLoading: Container(
//             height: 150,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: Colors.black,
//             ),
//           ).shimmer(),
//         ),
//         AppSpacers.height16,
//         productCategoriesController.obx(
//           (categoriesList) {
//             return HomeCategoriesListView(
//               categoriesList: categoriesList,
//               onCategoryTapped: (int categoryId) async {
//                 await Get.toNamed(
//                   Routes.PRODUCTS_LIST,
//                   arguments: categoryId.toString(),
//                 );
//               },
//             );
//           },
//           onLoading: HomeCategoriesListView(
//             categoriesList: [],
//             onCategoryTapped: (int categoryId) {
//               Get.toNamed(Routes.PRODUCTS_LIST);
//             },
//           ).shimmer(),
//         ),
//         AppSpacers.height16,
//         Expanded(
//           child: controller.obx((snapshot) {
//             return GridView.builder(
//               padding: EdgeInsets.only(top: 10),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: (itemWidth / itemHeight) / .35,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemCount: snapshot!.length,
//               itemBuilder: (_, index) {
//                 return GetBuilder<ProductFavoriteController>(
//                   init: ProductFavoriteController(),
//                   builder: (favoriteController) {
//                     return ProductCardView(
//                       imageUrl: snapshot[index]["image"].toString(),
//                       name: snapshot[index]["name"].toString(),
//                       hasDiscount: snapshot[index]["old_price"] != 0,
//                       isAvailable: snapshot[index]["quantity"] > 1,
//                       price: snapshot[index]["price"].toString(),
//                       oldPrice: snapshot[index]["old_price"].toString(),
//                       isFavorite: favoriteController
//                           .productIsFavorite(snapshot[index]["id"] as int),
//                       onAddToCartTapped: () {
//                         cartController.addToCart(
//                           productId: snapshot[index]["id"].toString(),
//                           quantity: '1',
//                           isNew: true,
//                         );
//                       },
//                       onFavoriteTapped: () {
//                         if (Get.put(AuthenticationController().isLoggedIn) ==
//                             false) {
//                           return AppDialogs.showToast(
//                               message: 'الرجاء تسجيل الدخول');
//                         }
//                         final favCon = Get.put<ProductFavoriteController>(
//                           ProductFavoriteController(),
//                         );

//                         favCon.addRemoveProductFromFavorite(
//                           productId: snapshot[index]["id"],
//                         );
//                       },
//                       //, product.isFavorite,
//                       onTap: () {
//                         Get.toNamed(
//                           Routes.PRODUCT_DETAILS,
//                           arguments: snapshot[index]["id"].toString(),
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//             );
//           }),
//         ),
//       ],
//     ));
//   }

//   void toggleFavorite(int productId, List<dynamic>? snapshot) {
//     final product = (snapshot as List).firstWhere(
//       (p) => p['id'] == productId,
//     );

//     product['is_favorite'] = !product['is_favorite'];
//     controller.update();
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

RxInt KProductHighestPrice = 0.obs;

class OfferProductController extends GetxController with StateMixin<List> {
  @override
  void onInit() {
    getOffersProduct();
    super.onInit();
  }

  void getOffersProduct() async {
    ResponseModel responseModel = await WebServices().getOffersProduct();
    if (responseModel.data["success"]) {
      if ((responseModel.data["data"]["data"] as List).length == 0) {
        change(null, status: RxStatus.empty());
        return;
      }

      KProductHighestPrice.value = responseModel.data["data"]["highest_price"];

      change(responseModel.data["data"]["data"], status: RxStatus.success());
      return;
    }

    change(null, status: RxStatus.error());
  }
}

class OfferProductView extends GetView<OfferProductController> {
  OfferProductView({Key? key}) : super(key: key);
  final controller = Get.put(OfferProductController());
  final cartController = Get.find<ShoppingCartController>();
  @override
  Widget build(BuildContext context) {
    final double itemHeight = (Get.height - kToolbarHeight - 24) / 1;
    final double itemWidth = Get.width / 2;

    return Scaffold(
      body: controller.obx((snapshot) {
        return GridView.builder(
          padding: EdgeInsets.only(top: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight) / .35,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: snapshot!.length,
          itemBuilder: (_, index) {
            return GetBuilder<ProductFavoriteController>(
              init: ProductFavoriteController(),
              builder: (favoriteController) {
                return ProductCardView(
                  imageUrl: snapshot[index]["image"].toString(),
                  name: snapshot[index]["name"].toString(),
                  hasDiscount: snapshot[index]["old_price"] != 0,
                  isAvailable: snapshot[index]["quantity"] > 1,
                  price: snapshot[index]["price"].toString(),
                  oldPrice: snapshot[index]["old_price"].toString(),
                  isFavorite: favoriteController
                      .productIsFavorite(snapshot[index]["id"] as int),
                  onAddToCartTapped: () {
                    if ((snapshot[index]['variants'] as List).isNotEmpty) {
                      AppDialogs.showToast(
                        message: 'هذا المنتج يحتوى على الوان يجب اختيار اللون',
                      );
                      Get.toNamed(
                        Routes.PRODUCT_DETAILS,
                        arguments: snapshot[index]["id"].toString(),
                      );

                      return;
                    }
                    cartController.addToCart(
                      productId: snapshot[index]["id"].toString(),
                      quantity: '1',
                      isNew: true,
                    );
                  },
                  onFavoriteTapped: () {
                    if (Get.put(AuthenticationController().isLoggedIn) ==
                        false) {
                      return AppDialogs.showToast(
                          message: 'الرجاء تسجيل الدخول');
                    }
                    final favCon = Get.put<ProductFavoriteController>(
                      ProductFavoriteController(),
                    );

                    favCon.addRemoveProductFromFavorite(
                      productId: snapshot[index]["id"],
                    );
                  },
                  //, product.isFavorite,
                  onTap: () {
                    Get.toNamed(
                      Routes.PRODUCT_DETAILS,
                      arguments: snapshot[index]["id"].toString(),
                    );
                  },
                );
              },
            );
          },
        );
      }),
    );
  }

  void toggleFavorite(int productId, List<dynamic>? snapshot) {
    final product = (snapshot as List).firstWhere(
      (p) => p['id'] == productId,
    );

    product['is_favorite'] = !product['is_favorite'];
    controller.update();
  }
}
