import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/slider_painter_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class PriceRangeSliderView extends GetView {
  final int min;
  final int max;
  final ValueChanged<RangeValues>? onChanged;
  final RangeValues? initValue;

  const PriceRangeSliderView({
    Key? key,
    required this.min,
    required this.max,
    required this.onChanged,
    this.initValue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Rx<RangeValues> rangeValues = Rx<RangeValues>(
      initValue ??
          RangeValues(
            min.toDouble(),
            max.toDouble(),
          ),
    );

    late IndicatorRangeSliderThumbShape<int> indicatorRangeSliderThumbShape =
        initValue == null
            ? IndicatorRangeSliderThumbShape(min, max)
            : IndicatorRangeSliderThumbShape(
                initValue?.start.toInt() ?? 0,
                initValue?.end.toInt() ?? 0,
              );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'السعر',
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.blackColor,
            letterSpacing: 0.18,
            fontWeight: FontWeight.w500,
            height: 0.67,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height25,
        SliderTheme(
          data: Theme.of(Get.context!).sliderTheme.copyWith(
                rangeThumbShape: indicatorRangeSliderThumbShape,
                showValueIndicator: ShowValueIndicator.never,
                thumbColor: AppColors.mainColor,
                activeTrackColor: AppColors.mainColor,
                inactiveTrackColor: Color(0xffE5E1E8),
                overlayColor: AppColors.mainColor.withOpacity(.2),
                trackHeight: 1.4,
              ),
          child: Obx(
            () => RangeSlider(
              values: rangeValues.value,
              onChanged: (values) {
                indicatorRangeSliderThumbShape.start = values.start.toInt();
                indicatorRangeSliderThumbShape.end = values.end.toInt();

                rangeValues.value = RangeValues(values.start, values.end);

                onChanged!.call(values);
              },
              min: min.toDouble(),
              max: max.toDouble(),
            ),
          ),
        )
      ],
    );
  }
}
