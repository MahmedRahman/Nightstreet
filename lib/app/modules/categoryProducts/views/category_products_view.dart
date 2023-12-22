import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/category_product_app_bar.dart';
import 'package:app_night_street/core/component/circular_icon.dart';
import 'package:app_night_street/core/component/product_subcategories_list_view.dart';
import 'package:app_night_street/core/component/meal_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/category_products_controller.dart';

class CategoryProductsView extends GetView<CategoryProductsController> {
  const CategoryProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: CategoryProductAppBar(
        elevation: 4,
        backgroundColor: Colors.white,
        titleText: 'مشروبات',
        actions: [
          CircularIcon(
            iconPath: 'images/svg/filter_icon.svg',
            onTap: () {},
          ),
          const SizedBox(width: 17),
          CircularIcon(
            iconPath: 'images/svg/search_icon.svg',
            onTap: () {},
          ),
          const SizedBox(width: 17),
        ],
        flexibleSpace: subCategories(),
      ),
      child: ListView(
        padding: AppDimension.appPadding.copyWith(
          top: 16,
          bottom: 16,
        ),
        children: [
          MealItem(),
          MealItem(),
          MealItem(),
        ],
      ),
    );
  }

  Padding subCategories() {
    return Padding(
      padding: AppDimension.appPadding.copyWith(bottom: 10),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: HomeCategoriesListView(
          categoriesList: [
            {"id": 1, "name": "المشروبات"},
            {"id": 2, "name": "لحوم"},
            {"id": 3, "name": "معلبات"},
            {"id": 4, "name": "مسليات"},
          ],
          onCategoryTapped: (int categoryId) async {},
        ),
      ),
    );
  }
}
