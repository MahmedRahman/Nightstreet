import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/product_details/controllers/product_review_controller.dart';
import 'package:krzv2/component/views/pages/app_page_loading_more.dart';
import 'package:krzv2/component/views/review_card_view.dart';

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

          if (index == reviews!.length - 1 && reviews.length != 1) {
            return AppPageLoadingMore(
              display: controller.status.isLoadingMore,
            );
          }

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
