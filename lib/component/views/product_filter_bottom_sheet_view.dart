import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/price_range_slider_view.dart';
import 'package:krzv2/component/views/product_brand_field_view.dart';
import 'package:krzv2/component/views/product_filter_items_view.dart';
import 'package:krzv2/models/product_filter_model.dart';
import 'package:krzv2/models/product_search_query.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ProductFilterBottomSheetView extends GetView {
  ProductFilterBottomSheetView({
    Key? key,
    required this.onChanged,
    required this.productQuery,
    required this.onResetTapped,
    required this.max,
  }) : super(key: key);
  final int max;
  final ValueChanged<ProductQueryParameters> onChanged;
  final selectedFilterType = Rx<ProductFilterModel?>(null);
  final princeRangeRx = Rx<RangeValues?>(null);
  final brandIds = Rx<List<int>?>(null);
  final Function() onResetTapped;

  final ProductQueryParameters productQuery;

  customInit() {
    // init rate
    if (productQuery.filter != '' && productQuery.filter != null) {
      selectedFilterType.value = ProductFilterModel(
        searchKey: productQuery.filter ?? '',
        title: productFilterItems.firstWhereOrNull((element) => element.searchKey == productQuery.filter)?.title ?? '',
      );
    }
    // end init rate

    // init price range
    if (productQuery.startPrice != null && productQuery.endPrice != null) {
      princeRangeRx.value = RangeValues(
        productQuery.startPrice!,
        productQuery.endPrice!,
      );
    }
    // end init price range

    // init brands
    if (productQuery.brandIds != null && productQuery.brandIds!.isNotEmpty) {
      brandIds.value = productQuery.brandIds!.map((e) => int.parse(e)).toList();
    }

    // end init brands
  }

  @override
  Widget build(BuildContext context) {
    customInit();
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 1.7,
        sigmaY: 1.7,
      ),
      child: SizedBox(
        height: Get.height * .80,
        child: SingleChildScrollView(
          child: Padding(
            padding: AppDimension.appPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacers.height19,
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
                Divider(),
                AppSpacers.height16,
                ProductBrandFieldView(
                  initBandsIds: brandIds.value ?? [],
                  onChanged: (List<int> value) {
                    brandIds.value = value;
                  },
                ),
                Divider(),
                AppSpacers.height16,
                PriceRangeSliderView(
                  min: 0,
                  max: 1000,
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
                          brandIds.value = null;

                          productQuery.filter = null;

                          productQuery.startPrice = null;
                          productQuery.endPrice = null;
                          productQuery.brandIds = null;
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
                          productQuery.filter = selectedFilterType.value?.searchKey;

                          productQuery.startPrice = princeRangeRx.value?.start;
                          productQuery.endPrice = princeRangeRx.value?.end;
                          productQuery.brandIds = brandIds.value?.map((e) => e.toString()).toList();

                          onChanged(productQuery);
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
