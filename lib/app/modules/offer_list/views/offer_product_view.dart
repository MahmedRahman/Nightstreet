import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

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
      change(responseModel.data["data"]["data"], status: RxStatus.success());
      return;
    }

    change(null, status: RxStatus.error());
  }
}

class OfferProductView extends GetView<OfferProductController> {
  OfferProductView({Key? key}) : super(key: key);
  OfferProductController controller = Get.put(OfferProductController());
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
            childAspectRatio: (itemWidth / itemHeight) / .42,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: snapshot!.length,
          itemBuilder: (_, index) {
            final idOdd = index.isOdd;
            return ProductCardView(
              imageUrl: snapshot[index]["image"].toString(),
              name: snapshot[index]["name"].toString(),
              hasDiscount: snapshot[index]["oldPrice"] != 0,
              price: snapshot[index]["price"].toString(),
              onAddToCartTapped: () {
                // cartController.addToCart(
                //   productId: product.id.toString(),
                //   quantity: '1',
                //   isNew: true,
                // );
              },
              onFavoriteTapped: () {
                // final favCon = Get.put<ProductFavoriteController>(
                //   ProductFavoriteController(),
                // );
                // controller.toggleFavorite(product.id);

                // favCon.addRemoveProductFromFavorite(
                //   productId: product.id,
                //   onError: () {
                //     controller.toggleFavorite(product.id);
                //   },
                // );
              },
              isFavorite: true, //, product.isFavorite,
              onTap: () async {
                // final awaitId = await Get.toNamed(
                //   Routes.PRODUCT_DETAILS,
                //   arguments: product.id.toString(),
                // );

                // if (awaitId != null && awaitId != '') {
                //   controller.toggleFavorite(product.id);
                // }
              },
            );

            // ProductCardView(
            //   imageUrl:
            //       'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1646077574-screen-shot-2022-02-28-at-2-39-10-pm-1646077556.png?crop=1xw:0.9974358974358974xh;center,top&resize=980:*',
            //   name: 'مضاد التعرق كول راش من ديجري مين، يدوم ..لمدة 48 ساعة',
            //   hasDiscount: false,
            //   price: '1760',
            //   rate: '4.9',
            //   isLimitedQuantity: idOdd ? true : false,
            //   onAddToCartTapped: () {},
            //   onFavoriteTapped: () {},
            //   isFavorite: false,
            //   onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS),
            // );
          },
        );
      }),
    );
  }

  // Center Product_item_card() {
  //   return Center(
  //     child: Container(
  //       width: 172,
  //       height: 250,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         color: Colors.white,
  //         border: Border.all(
  //           width: 1.0,
  //           color: Color(0xff7C3A5B),
  //         ),
  //       ),
  //       child: Stack(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 ClipRRect(
  //                   borderRadius: BorderRadius.circular(10), // Image border
  //                   child: Image.asset(
  //                     "assets/image/dummy/dummy_product.png",
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   'مضاد التعرق كول راش من ديجري مين، يدوم ..لمدة 48 ساعة',
  //                   style: TextStyle(
  //                     fontFamily: 'Effra',
  //                     fontSize: 14.0,
  //                     color: Color(0xff3B3B3B),
  //                     letterSpacing: 0.35000000000000003,
  //                     height: 1.64,
  //                   ),
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   textAlign: TextAlign.right,
  //                 ),
  //                 SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   '1760 ر.س',
  //                   style: TextStyle(
  //                     fontSize: 13.0,
  //                     color: const Color(0xFF1F1F1F),
  //                     fontWeight: FontWeight.w500,
  //                     height: 1.46,
  //                   ),
  //                   textAlign: TextAlign.right,
  //                 ),

  //                 Row(
  //                   children: [
  //                     MaterialButton(
  //                       onPressed: () {},
  //                       child: Text(
  //                         'إضافة للسلة',
  //                         style: TextStyle(
  //                           fontSize: 13.0,
  //                           height: 1.46,
  //                         ),
  //                       ),
  //                       color: Color(0xffFAFAFA),
  //                       elevation: 0,
  //                     ),
  //                     Spacer(),
  //                     SizedBox(
  //                       width: 40,
  //                       child: MaterialButton(
  //                         onPressed: () {},
  //                         child: SvgPicture.asset("assets/svg/heart.svg"),
  //                         color: Color(0xffFAFAFA),
  //                         elevation: 0,
  //                       ),
  //                     ),
  //                   ],
  //                 ),

  //                 // Row(
  //                 //   children: [

  //                 //     SizedBox(
  //                 //       width: 10,
  //                 //     ),

  //                 //   ],
  //                 // ),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   child: Container(
  //                     alignment: Alignment.center,
  //                     width: 60.0,
  //                     height: 20.0,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                       color: Color(0xff7C3A5B),
  //                     ),
  //                     child: Text(
  //                       'الكمية محدودة',
  //                       style: TextStyle(
  //                         fontFamily: 'Effra',
  //                         fontSize: 10.0,
  //                         color: Colors.white,
  //                         height: 1,
  //                       ),
  //                       textAlign: TextAlign.right,
  //                     ),
  //                   ),
  //                 ),
  //                 Spacer(),
  //                 Container(
  //                   alignment: Alignment.center,
  //                   width: 40.0,
  //                   height: 20.0,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(5.0),
  //                     color: Colors.white.withOpacity(0.95),
  //                   ),
  //                   child: SizedBox(
  //                     width: 35.0,
  //                     // height: 12.16,
  //                     child: Row(
  //                       children: [
  //                         Icon(
  //                           Icons.star,
  //                           size: 12,
  //                         ),
  //                         Spacer(),
  //                         Text(
  //                           '4.9',
  //                           style: TextStyle(
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w500,
  //                             height: 1.4,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
