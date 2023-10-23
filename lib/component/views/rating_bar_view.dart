import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/utils/app_colors.dart';

class RatingBarView extends GetView {
  const RatingBarView({
    Key? key,
    required this.initRating,
    required this.totalRate,
    this.ignoreGestures = false,
    this.itemSize = 12,
    this.onRatingUpdate,
    this.displayTotalRate = true,
  }) : super(key: key);

  final num initRating;
  final num totalRate;
  final bool? ignoreGestures;
  final double? itemSize;
  final ValueChanged<double>? onRatingUpdate;
  final bool displayTotalRate;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar(
          ignoreGestures: ignoreGestures!,
          tapOnlyMode: true,
          initialRating: initRating.toDouble(),
          direction: Axis.horizontal,
          itemCount: 5,
          glowColor: Colors.white,
          itemSize: itemSize!,
          ratingWidget: RatingWidget(
            full: SvgPicture.asset(AppSvgAssets.selectedStarIcon),
            half: SizedBox(),
            empty: SvgPicture.asset(
              AppSvgAssets.unSelectedStarStarIcon,
            ),
          ),
          onRatingUpdate: (rating) => onRatingUpdate?.call(rating),
          itemPadding: EdgeInsets.only(left: 3),
        ),
        SizedBox(
          width: 5.5,
        ),
        Visibility(
          visible: displayTotalRate,
          child: Text(
            "(${totalRate.toInt()})",
            style: TextStyle(
              fontSize: 12.0,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              height: 1.58,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
