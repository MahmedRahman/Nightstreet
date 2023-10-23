import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_check_view.dart';
import 'package:krzv2/models/product_filter_model.dart';
import 'package:krzv2/utils/app_colors.dart';

class ProductFilterItemsView extends GetView {
  final ValueChanged<ProductFilterModel> onChanged;
  const ProductFilterItemsView({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _selectedItem = productFilterItems.first.obs;

    return Obx(
      () => Column(
        children: productFilterItems.map(
          (ProductFilterModel filterEntity) {
            return GestureDetector(
              onTap: () {
                _selectedItem.value = filterEntity;
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: filterEntity == _selectedItem.value
                            ? AppColors.mainColor
                            : AppColors.borderColor2,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      CustomCheckView(
                        iconColor: filterEntity == _selectedItem.value
                            ? AppColors.mainColor
                            : AppColors.greyColor,
                        backgroundColor: filterEntity == _selectedItem.value
                            ? Color(0xffE6D1D9)
                            : AppColors.borderColor2,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        filterEntity.title,
                      ),
                    ],
                  ).paddingAll(14)),
            );
          },
        ).toList(),
      ),
    );
  }
}
