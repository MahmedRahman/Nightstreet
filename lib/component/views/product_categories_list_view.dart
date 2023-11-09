import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/category_card_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ProductCategoriesListView extends GetView {
  final List<dynamic> productCategoriesList;
  final Function(int)? onTap;
  const ProductCategoriesListView({
    Key? key,
    required this.productCategoriesList,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'أقسام المنتجات',
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
          AppSpacers.height12,
          SizedBox(
            height: 95,
            child: ListView.builder(
              itemCount: productCategoriesList.length,
              padding: const EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = productCategoriesList.elementAt(index);
                return CategoryCardView(
                  title: category['name'],
                  imageUrl: category['image'],
                  onTap: () => onTap!(category['id']),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
