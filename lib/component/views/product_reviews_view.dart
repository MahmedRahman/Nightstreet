import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/product_details/controllers/product_review_controller.dart';
import 'package:krzv2/component/views/review_card_view.dart';
import 'package:krzv2/extensions/widget.dart';

class ProductReviewsView extends GetView<ProductReviewController> {
  const ProductReviewsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (reviews) => ListView.builder(
        controller: controller.scroll,
        itemCount: reviews?.length,
        itemBuilder: (context, index) {
          final review = reviews?.elementAt(index);
          return ReviewCardView(
            name: review!.name,
            rate: review.rate,
            comment: review.message,
            date: review.date,
          );
        },
      ),
      onLoading: ListView.builder(
        controller: controller.scroll,
        itemCount: 2,
        itemBuilder: (_, __) {
          return ReviewShimer();
        },
      ),
      onEmpty: Center(
        child: Text('لا يوجد تعليقات'),
      ),
    );
  }
}
