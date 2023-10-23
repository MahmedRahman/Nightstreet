import 'package:flutter/material.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class CategoriesShimmer extends StatelessWidget {
  final String categoryTitle;
  const CategoriesShimmer({
    super.key,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryTitle,
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
          AppSpacers.height12,
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 72,
                  margin: const EdgeInsets.only(left: 8),
                  constraints: BoxConstraints(
                    maxWidth: 72,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    border: Border.all(
                      width: 1.0,
                      color: AppColors.greyColor2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 6,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black,
                          ),
                        ).shimmer(),
                        AppSpacers.height5,
                        Container(
                          width: 40,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black,
                          ),
                        ).shimmer(),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
