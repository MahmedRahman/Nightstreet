import 'package:app_night_street/app/modules/homePage/views/home_page_view.dart';
import 'package:app_night_street/core/component/custom_base_scaffold.dart';
import 'package:app_night_street/core/component/meal_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      //appBar: Base,
      body: ListView(
        children: [
          address(),
          SizedBox(
            height: 10,
          ),
          serechBox(),
          SizedBox(
            height: 10,
          ),
          MealItem(),
          MealItem(),
          MealItem(),
        ],
      ),
    );
  }
}
