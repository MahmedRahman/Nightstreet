import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/rating_bar_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ReviewCardView extends GetView {
  const ReviewCardView({
    Key? key,
    required this.name,
    required this.comment,
    required this.rate,
    required this.date,
  }) : super(key: key);

  final String name;
  final String comment;
  final String date;

  final num rate;

  ReviewCardView.dummy({
    Key? key,
  })  : this.name = 'آدم محمود',
        this.rate = 2,
        this.date = '',
        this.comment =
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.blackColor,
            letterSpacing: 0.28,
            height: 0.86,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingBarView(
              initRating: rate,
              totalRate: 0,
              displayTotalRate: false,
            ),
            Text(
              date.toString(),
              style: TextStyle(
                fontSize: 14.0,
                color: const Color(0xFFD0CECE),
                height: 1.79,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        AppSpacers.height16,
        Text(
          comment,
          style: TextStyle(
            fontSize: 14.0,
            letterSpacing: 0.266,
            height: 1.79,
          ),
          textAlign: TextAlign.right,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
      ],
    );
  }
}

class ReviewShimer extends StatelessWidget {
  const ReviewShimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          height: 10,
          color: Colors.black,
        ).shimmer(),
        AppSpacers.height10,
        Container(
          width: 60,
          height: 10,
          color: Colors.black,
        ).shimmer(),
        AppSpacers.height16,
        Container(
          width: 130,
          height: 10,
          color: Colors.black,
        ).shimmer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
      ],
    );
  }
}
