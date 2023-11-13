import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/gender_selection_view.dart';
import 'package:krzv2/component/views/price_range_slider_view.dart';
import 'package:krzv2/component/views/product_filter_items_view.dart';

import 'package:krzv2/models/product_filter_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ServiceFilterModel {
  String? filter;
  String? target;
  double? startPrice;
  double? endPrice;
}

class ServiceFilterBottomSheetView extends GetView {
  ServiceFilterBottomSheetView({
    Key? key,
    required this.maxPrice,
    required this.query,
    required this.onChanged,
    required this.onResetTapped,
  }) : super(key: key);

  final int maxPrice;
  final ServiceFilterModel query;
  final princeRangeRx = Rx<RangeValues?>(null);
  final ValueChanged<ServiceFilterModel> onChanged;
  final RxString target = ''.obs;
  final selectedFilterType = Rx<ProductFilterModel?>(null);
  final Function() onResetTapped;

  customInit() {
    // init rate
    if (query.filter != '' && query.filter != null) {
      selectedFilterType.value = ProductFilterModel(
        searchKey: query.filter ?? '',
        title: productFilterItems
                .firstWhereOrNull(
                    (element) => element.searchKey == query.filter)
                ?.title ??
            '',
      );
    }
    // end init rate

    // init price range
    if (query.startPrice != null && query.endPrice != null) {
      princeRangeRx.value = RangeValues(
        query.startPrice!,
        max(maxPrice.toDouble(), query.endPrice ?? 0).toInt().toDouble(),
      );
    } // end init price range

    // init gender
    if (query.target != null && query.target! != '') {
      target.value = query.target ?? '';
    }

    // end init brands
  }

  @override
  Widget build(BuildContext context) {
    customInit();
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
                  initValue: selectedFilterType.value,
                  onChanged: (ProductFilterModel value) {
                    selectedFilterType.value = value;
                  },
                ),
                GenderSelectionView(
                  initValue: target.value,
                  onChanged: (String gender) {
                    target.value = gender;
                  },
                ),
                // AppSpacers.height16,
                // SubCategoriesDropmenuView(
                //   onChanged: (int value) {},
                // ),
                AppSpacers.height16,
                PriceRangeSliderView(
                  min: 0,
                  max: max(maxPrice.toDouble(), query.endPrice ?? 0).toInt(),
                  initValue: princeRangeRx.value,
                  onChanged: (RangeValues value) {
                    princeRangeRx.value = value;
                  },
                ),
                AppSpacers.height50,
                Row(
                  children: [
                    Expanded(
                      child: CustomBtnCompenent.secondary(
                        text: "الغاء",
                        onTap: () {
                          selectedFilterType.value = null;
                          princeRangeRx.value = null;
                          target.value = '';

                          query.filter = null;
                          query.startPrice = null;
                          query.endPrice = null;
                          query.target = null;
                          Get.back();
                          onResetTapped();
                        },
                      ),
                    ),
                    AppSpacers.width10,
                    Expanded(
                      flex: 3,
                      child: CustomBtnCompenent.main(
                        text: "فلترة النتائج",
                        onTap: () {
                          query.filter = selectedFilterType.value?.searchKey;

                          query.startPrice = princeRangeRx.value?.start;
                          query.endPrice = princeRangeRx.value?.end;
                          query.target = target.value;

                          onChanged(query);
                          Get.back();
                        },
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
