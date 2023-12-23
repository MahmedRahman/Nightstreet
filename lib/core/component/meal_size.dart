import 'package:app_night_street/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealSize extends GetView {
  final Function(String) onSizedChanged;
  final String? initId;
  MealSize({
    Key? key,
    required this.onSizedChanged,
    this.initId,
  }) {
    if (initId != null || initId != '') {
      selectedSize.value = initId ?? '0';
    }
  }
  final RxString selectedSize = ''.obs;
  final List<dynamic> sizeList = ["S", "M", "L"];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(
          () => Row(
            children: [
              ...sizeList.map(
                (category) => sizeButton(
                  isSelect: selectedSize.value == category,
                  title: category,
                  onTap: () {
                    selectedSize.value = category;
                    onSizedChanged(category);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding sizeButton({
    required bool isSelect,
    required String title,
    required Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 26,
      ),
      child: InkWell(
        onTap: onTap,
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        child: Container(
          height: 43,
          width: 43,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: isSelect
                ? AppColor.KOrangeColor.withOpacity(.1)
                : Color(0xffF9F9F9),
            border: Border.all(
              width: 1.0,
              color: isSelect ? AppColor.KOrangeColor : Color(0xffE2E4E4),
            ),
          ),
          child: Center(
            child: Text(
              '$title',
              style: TextStyle(
                fontSize: 14.0,
                color: isSelect ? AppColor.KOrangeColor : Color(0xff6C727F),
                height: 0.86,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    );
  }
}
