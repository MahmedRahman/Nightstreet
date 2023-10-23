import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/category_card_view.dart';

class HomeCategoriesListView extends GetView {
  final List<dynamic> categoriesList;
  final Function(int) onCategoryTapped;
  const HomeCategoriesListView({
    Key? key,
    required this.categoriesList,
    required this.onCategoryTapped,
  }) : super(key: key);
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
          return CategoryCardView(
            title: category['name'],
            imageUrl: category['image'],
            onTap: () => onCategoryTapped(category['id']),
          );
        },
      ),
    );
  }
}
