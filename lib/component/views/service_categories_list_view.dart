import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/category_card_view.dart';
import 'package:krzv2/utils/app_colors.dart';

import 'package:krzv2/utils/app_spacers.dart';

class ServiceCategoriesListView extends GetView {
  final List<dynamic> serviceCategoriesList;
  final Function(int index)? onTap;
  const ServiceCategoriesListView({
    Key? key,
    required this.serviceCategoriesList,
    required this.onTap(int index),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      color: const Color(0xffFBFBFB),
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'أقسام الخدمات',
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
              itemCount: serviceCategoriesList.length,
              padding: const EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = serviceCategoriesList.elementAt(index);
                return CategoryCardView(
                  title: category["name"],
                  imageUrl: category["image"],
                  onTap: () {
                    onTap!(category["id"]);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
