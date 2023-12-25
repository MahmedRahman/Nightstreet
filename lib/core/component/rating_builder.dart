import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RatingBuilder extends GetView {
  const RatingBuilder({
    super.key,
    required this.rate,
    required this.userName,
    required this.rateDate,
  });

  final String rate;
  final String userName;
  final String rateDate;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.width,
        decoration: BoxDecoration(
          color: const Color(0x98f9f9f9),
          borderRadius: BorderRadius.circular(27.0),
          border: Border.all(width: 1.0, color: const Color(0x98e2e4e4)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                "images/svg/user_avatar.svg",
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyles.font13regularBlack,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    rateDate,
                    style: TextStyles.font13regularBlack,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const Spacer(),
              RatingBar(
                ignoreGestures: true,
                tapOnlyMode: true,
                initialRating: double.parse(rate),
                direction: Axis.horizontal,
                itemCount: 5,
                glowColor: Colors.red,
                itemSize: 18,
                ratingWidget: RatingWidget(
                  full: SvgPicture.asset("images/svg/full_rate.svg"),
                  half: SizedBox(),
                  empty: SvgPicture.asset("images/svg/empty_rate.svg"),
                ),
                onRatingUpdate: (rating) {},
                itemPadding: EdgeInsets.only(left: 3),
              ),
            ],
          ),
        ));
  }
}
