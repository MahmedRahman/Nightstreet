import 'package:flutter/material.dart';
import 'package:get/get.dart';

class mealDetailsFavIcon extends StatelessWidget {
  const mealDetailsFavIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Get.height * .37,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
            width: 1.0,
            color: const Color(0xffd8d8d8),
          ),
        ),
      ),
    );
  }
}
