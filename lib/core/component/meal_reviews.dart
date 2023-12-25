import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/rating_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealReviews extends GetView {
  const MealReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppDimension.appPadding.copyWith(top: 20),
      children: [
        RatingBuilder(
          rate: '3',
          userName: 'عصام السيد',
          rateDate: '2022-08-22 12:44:16',
        ),
      ],
    );
  }
}
