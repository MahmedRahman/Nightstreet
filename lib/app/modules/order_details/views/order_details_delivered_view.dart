import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/order_details_card_view.dart';
import 'package:krzv2/component/views/order_info_card_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsDeliveredView extends GetView<OrderDetailsController> {
  const OrderDetailsDeliveredView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'تفاصيل الطلب',
      ),
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          AppSpacers.height12,
          OrderInfoCardView(
            orderDate: 'الإثنـــين، 10 اكتوبر 2022م',
            orderNo: '58967895',
            status: 'تم التوصيل',
          ),
          AppSpacers.height12,
          Divider(),
          AppSpacers.height12,
          CustomBtnCompenent.main(
            text: 'تقييم الطلب',
            onTap: () => Get.toNamed(Routes.ORDER_REVIEW),
          ),
          AppSpacers.height12,
          Divider(),
          AppSpacers.height12,
          OrderDetailsCardView.demmy(),
          OrderDetailsCardView.demmy(),
          Divider(),
          AppSpacers.height12,
          DecoratedContainer(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  paymentSumaryItem(
                    title: "اجمالي المستحق لـ ( 4 منتج )",
                    value: "1760 رس",
                  ),
                  AppSpacers.height16,
                  paymentSumaryItem(
                    title: "مصاريف الشحــن",
                    value: "1760 رس",
                  ),
                  AppSpacers.height12,
                  DottedLine(
                    dashLength: 10,
                    dashGapLength: 5,
                    lineThickness: 3,
                    dashColor: AppColors.borderColor2,
                  ),
                  AppSpacers.height12,
                  paymentSumaryItem(
                    title: "اجمالي المبلغ",
                    value: "1000 رس",
                    textColor: AppColors.mainColor,
                  ),
                  AppSpacers.height12,
                ],
              ),
            ),
          ),
          AppSpacers.height12,
          Divider(),
          AppSpacers.height12,
          Row(
            children: [
              Expanded(
                child: CustomBtnCompenent.main(
                  text: 'اعادة الطلب',
                  onTap: () {},
                ),
              ),
              AppSpacers.width20,
              Expanded(
                child: InkWell(
                  onTap: () {
                    log('tapped');
                  },
                  child: DecoratedContainer(
                    height: 52,
                    child: Center(
                      child: Text(
                        'تحميل الفــاتورة',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Row paymentSumaryItem({
    required String title,
    required String value,
    Color? textColor = Colors.black,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            color: textColor,
            height: 1.36,
          ),
          textAlign: TextAlign.right,
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.0,
            color: textColor,
            height: 1.36,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
