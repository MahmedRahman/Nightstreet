import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/category_card_view.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class HomePageServiceCategoriesView extends GetView {
  HomePageServiceCategoriesView({
    Key? key,
    required this.categoriesList,
    required this.onCategoryTapped,
  }) : super(key: key);

  final List<dynamic> categoriesList;
  final Function(int) onCategoryTapped;
  final RxString selectedId = '0'.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.width,
        color: const Color(0xffFBFBFB),
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          right: 20,
        ),
        height: 115,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => Row(
              children: [
                AllSelection(
                  title: 'الكل',
                  image: AppSvgAssets.logoIcon,
                  isSelected: selectedId.value == '0',
                  onTap: () {
                    selectedId.value = '0';
                    onCategoryTapped(0);
                  },
                ),
                ...categoriesList
                    .map(
                      (category) => CategoryCardView(
                        title: category['name'],
                        imageUrl: category['image'],
                        isSelected:
                            selectedId.value == category['id'].toString(),
                        onTap: () {
                          selectedId.value = category['id'].toString();
                          onCategoryTapped(category['id']);
                        },
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ));
  }
}
