import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/models/variants_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ProductColorSelectorView extends GetView {
  ProductColorSelectorView({
    Key? key,
    required this.onChanged,
    required this.variants,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final List<Variant> variants;
  final Rx<Color> selectedColor = Rx<Color>(Colors.transparent);

  @override
  Widget build(BuildContext context) {
    if (variants.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        AppSpacers.height12,
        Text(
          'اختيار اللون :',
          style: TextStyle(
            fontSize: 16.0,
            color: AppColors.blackColor,
            letterSpacing: 0.24,
            height: 0.75,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height16,
        Obx(
          () => Row(
            children: variants.map(
              (variant) {
                final colorValue = {'name': variant.name};
                Color color = Color(int.parse('0xFF${colorValue['name']}'));
                return InkWell(
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  onTap: () {
                    selectedColor.value = color;
                    onChanged(variant.id.toString());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: selectedColor.value == color
                            ? AppColors.greyColor
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    width: 30,
                    height: 30,
                  ),
                );
              },
            ).toList(),
          ),
        ),
        AppSpacers.height12,
        Divider(),
      ],
    );
  }
}
