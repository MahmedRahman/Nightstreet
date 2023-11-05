import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/gender_selection_view.dart';
import 'package:krzv2/component/views/price_range_slider_view.dart';
import 'package:krzv2/component/views/product_filter_items_view.dart';
import 'package:krzv2/component/views/sub_categories_dropmenu_view.dart';
import 'package:krzv2/models/product_filter_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ServiceFilterBottomSheetView extends GetView {
  ServiceFilterBottomSheetView({
    Key? key,
    required int this.max,
  }) : super(key: key);

  final max;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1.7, sigmaY: 1.7),
      child: SizedBox(
        height: Get.height * .80,
        child: SingleChildScrollView(
          child: Padding(
            padding: AppDimension.appPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacers.height25,
                Center(
                  child: Container(
                    width: 94,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                ),
                AppSpacers.height40,
                Text(
                  'عرض حسب',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: AppColors.blackColor,
                    letterSpacing: 0.18,
                    fontWeight: FontWeight.w500,
                    height: 0.67,
                  ),
                  textAlign: TextAlign.right,
                ),
                AppSpacers.height12,
                ProductFilterItemsView(
                  onChanged: (ProductFilterModel value) {},
                ),
                GenderSelectionView(
                  onChanged: (String gender) {},
                ),
                AppSpacers.height16,
                SubCategoriesDropmenuView(
                  onChanged: (int value) {},
                ),
                AppSpacers.height16,
                PriceRangeSliderView(
                  min: 0,
                  max: max,
                  onChanged: (RangeValues value) {},
                ),
                AppSpacers.height50,
                Row(
                  children: [
                    Expanded(
                      child: CustomBtnCompenent.secondary(
                        text: "الغاء",
                        onTap: () => Get.back(),
                      ),
                    ),
                    AppSpacers.width10,
                    Expanded(
                      flex: 3,
                      child: CustomBtnCompenent.main(
                        text: "فلترة النتائج",
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                AppSpacers.height29,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
