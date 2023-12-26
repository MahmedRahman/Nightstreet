import 'package:app_night_street/app/routes/app_pages.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/category_builder.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double itemHeight = (Get.height - kToolbarHeight - 24) / 1;
    final double itemWidth = Get.width / 2;

    return BaseBody(
      appBar: CustomAppBar(titleText: "الأقسام"),
      child: GridView.builder(
        primary: false,
        itemCount: 10,
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: (itemWidth / itemHeight) / .35,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return CategoryBuilder(
            name: 'قسم ${index + 1}',
            imagePath: '',
            onTap: () => Get.toNamed(Routes.CATEGORY_PRODUCTS),
          );
        },
      ),
    );
  }
}
