import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/order_details_card_view.dart';
import 'package:krzv2/component/views/rating_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/models/order_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/order_review_controller.dart';

class OrderReviewView extends GetView<OrderReviewController> {
  OrderReviewView({
    Key? key,
    required this.orderId,
    required this.marketId,
    required this.products,
  }) : super(key: key);
  final int orderId;
  final int marketId;
  final List<OrderProdudctsDetails> products;

  final controller = Get.put(OrderReviewController());
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(titleText: 'تقييم الطلب'),
      body: Padding(
        padding: AppDimension.appPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              marketRateForm(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              ...products.map((product) {
                return ProductRateForm(
                  productImage: product.productImage,
                  productName: product.productName,
                  productQuantuty: product.quantity.toString(),
                  productPrice: product.price.toString(),
                  productOldPrice: product.oldPrice.toString(),
                  onTap: ({String? message, double? rate}) {
                    controller.rateOrderProduct(
                      orderId: orderId.toString(),
                      productId: product.productId.toString(),
                      rate: rate!.toInt().toString(),
                      message: message,
                    );
                  },
                );
              }).toList(),
              // Expanded(
              //   child: ListView.separated(
              //     itemCount: products.length,
              //     padding: AppDimension.appPadding,
              //     itemBuilder: (context, index) {
              //       final product = products.elementAt(index);

              //       return ProductRateForm(
              //         productImage: product.productImage,
              //         productName: product.productName,
              //         productQuantuty: product.quantity.toString(),
              //         productPrice: product.price.toString(),
              //         productOldPrice: product.oldPrice.toString(),
              //         onTap: ({String? message, double? rate}) {
              //           controller.rateOrderProduct(
              //             orderId: orderId.toString(),
              //             productId: product.productId.toString(),
              //             rate: rate!.toInt().toString(),
              //             message: message,
              //           );
              //         },
              //       );
              //     },
              //     separatorBuilder: (BuildContext context, int index) =>
              //         Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 10),
              //       child: Divider(),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  final RxDouble _marketRate = 1.0.obs;
  final marketMessageController = TextEditingController();
  Widget marketRateForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacers.height16,
        Text(
          'ما تقييمك لهذه المتجر؟',
          style: TextStyle(
            fontSize: 16.0,
            letterSpacing: 0.24,
            height: 0.75,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height10,
        RatingBarView(
          initRating: 1,
          totalRate: 0,
          displayTotalRate: false,
          itemSize: 20,
          onRatingUpdate: (double vlu) {
            _marketRate.value = vlu;
          },
        ),
        AppSpacers.height10,
        TextFieldComponent.longMessage(
          outLineText: "",
          hintText: "اكتب شيئًا عن هذا المتجر؟",
          controller: marketMessageController,
        ),
        AppSpacers.height10,
        CustomBtnCompenent.main(
          width: 120,
          text: "إرسال",
          onTap: () {
            controller.rateMarket(
              orderId: orderId.toString(),
              marketId: marketId.toString(),
              rate: _marketRate.value.toInt().toString(),
              message: marketMessageController.text,
            );
          },
        ),
      ],
    );
  }
}

class ProductRateForm extends StatelessWidget {
  ProductRateForm({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productQuantuty,
    required this.productPrice,
    required this.productOldPrice,
    required this.onTap,
  });

  final String productImage;
  final String productName;
  final String productPrice;
  final String productQuantuty;
  final String productOldPrice;
  final Function({required double rate, required String message}) onTap;

  final RxDouble _rate = 1.0.obs;
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrderDetailsCardView(
          image: productImage,
          price: productPrice,
          name: productName,
          oldPrice: productOldPrice,
          quantity: productQuantuty,
        ),
        Divider(),
        AppSpacers.height12,
        Text(
          'ما تقييمك لهذا المنتج ؟',
          style: TextStyle(
            fontSize: 16.0,
            color: AppColors.blackColor,
            letterSpacing: 0.24,
            height: 0.75,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height12,
        RatingBarView(
          initRating: 1,
          totalRate: 0,
          displayTotalRate: false,
          itemSize: 20,
          onRatingUpdate: (double vlu) {
            _rate.value = vlu;
          },
        ),
        AppSpacers.height12,
        Divider(),
        TextFieldComponent.longMessage(
          controller: messageController,
          outLineText: '',
          hintText: 'اكتب شيئًا عن هذا المنتج',
        ),
        AppSpacers.height12,
        Row(
          children: [
            CustomBtnCompenent.main(
              width: 130,
              text: 'إرسال',
              onTap: () {
                onTap(rate: _rate.value, message: messageController.text);
              },
            ),
          ],
        ),
      ],
    );
  }
}
