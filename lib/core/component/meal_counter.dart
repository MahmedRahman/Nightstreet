import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MealCounter extends GetView {
  MealCounter({
    super.key,
    required this.onCounterChanged,
    this.enabled = true,
  });

  final RxInt _counter = 1.obs;
  final Function(int) onCounterChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: 120,
      decoration: BoxDecoration(
        color: const Color(0x98f9f9f9),
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0x98e2e4e4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              if (enabled == false) return;
              _counter.value++;
              onCounterChanged(_counter.value);
            },
            overlayColor: MaterialStatePropertyAll(Colors.transparent),
            child: Icon(
              Icons.add,
              color: AppColor.KBlackColor2,
            ),
          ),
          Obx(
            () => Text(
              _counter.value.toString(),
              style: TextStyles.font16regularBlack2,
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.right,
              softWrap: false,
            ),
          ),
          InkWell(
            onTap: () {
              if (enabled == false) return;
              if (_counter.value == 1) return;
              _counter.value--;

              onCounterChanged(_counter.value);
            },
            overlayColor: MaterialStatePropertyAll(Colors.transparent),
            child: Icon(
              Icons.remove,
              color: AppColor.KBlackColor2,
            ),
          ),
        ],
      ),
    );
  }
}
