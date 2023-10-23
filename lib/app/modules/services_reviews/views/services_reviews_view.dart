import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/review_card_view.dart';

import '../controllers/services_reviews_controller.dart';

class ServicesReviewsView extends GetView<ServicesReviewsController> {
  const ServicesReviewsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ReviewCardView(
          name: 'آدم محمود',
          rate: 4,
          comment:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم\nتوليد هذا النص من مولد النص العربى',
                      date: "s",

        );
      },
    );
  }
}
