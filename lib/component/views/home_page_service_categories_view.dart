import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/category_card_view.dart';

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
      child: ListView.builder(
        itemCount: categoriesList.length,
        padding: const EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categoriesList.elementAt(index);
          return Obx(
            () => CategoryCardView(
              title: category['name'],
              imageUrl: category['image'],
              isSelected: selectedId.value == category['id'].toString(),
              onTap: () {
                selectedId.value = category['id'].toString();
                onCategoryTapped(category['id']);
              },
            ),
          );
        },
      ),
    );
  }
}
