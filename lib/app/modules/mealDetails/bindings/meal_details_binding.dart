import 'package:get/get.dart';

import '../controllers/meal_details_controller.dart';

class MealDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealDetailsController>(
      () => MealDetailsController(),
    );
  }
}
