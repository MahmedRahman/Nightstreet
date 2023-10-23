import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/review_card_view.dart';
import 'package:krzv2/extensions/widget.dart';

import '../controllers/review_Information_controller.dart';

class ReviewInformationView extends GetView {
  ReviewInformationController controller = Get.put(ReviewInformationController());

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (snapshot) {
        return ListView.builder(
          itemCount: snapshot!.length,
          itemBuilder: (context, index) {
            return ReviewCardView(
              name: snapshot.elementAt(index)["name"],
              rate: snapshot.elementAt(index)["rate"],
              comment: snapshot.elementAt(index)["message"],
              date: snapshot.elementAt(index)["date"],
            );
          },
        );
      },
      onLoading: ReviewCardView(
        name: 'آدم محمود',
        rate: 4,
        comment: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم\nتوليد هذا النص من مولد النص العربى',
        date: "s",
      ).shimmer(),
      onEmpty: Container(
        child: Center(child: Text("لا يوجد تقيمات")),
      ),
    );
  }
}
