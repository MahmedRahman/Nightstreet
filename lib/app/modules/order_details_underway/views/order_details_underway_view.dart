import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/order_details/controllers/order_details_controller.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/order_details_card_view.dart';
import 'package:krzv2/component/views/order_info_card_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/order_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

class OrderDetailsUnderwayView extends GetView<OrderDetailsController> {
  const OrderDetailsUnderwayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'تفاصيل الطلب',
      ),
      body: controller.obx(
        (OrderModel? order) {
          return ListView(
            padding: AppDimension.appPadding,
            children: [
              AppSpacers.height12,
              OrderInfoCardView(
                orderDate: order!.createdAt,
                orderNo: order.id.toString(),
                status: order.status,
                statusNum: order.statusNum,
              ),
              AppSpacers.height12,
              Divider(),
              AppSpacers.height12,
              ...order.details!.map(
                (detail) {
                  return OrderDetailsCardView(
                    image: detail.productImage,
                    price: detail.price.toString(),
                    name: detail.productName,
                    oldPrice: detail.oldPrice.toString(),
                    quantity: detail.quantity.toString(),
                  );
                },
              ),
              Divider(),
              AppSpacers.height12,
              DecoratedContainer(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      paymentSumaryItem(
                        title:
                            "اجمالي المستحق لـ ( ${order.details?.length} منتج )",
                        value: "${order.subTotal} رس",
                      ),
                      AppSpacers.height10,
                      paymentSumaryItem(
                        title: "ضريبة القيمة المضافة (15%)",
                        value: "${order.tax} رس",
                      ),
                      AppSpacers.height10,
                      paymentSumaryItem(
                        title: "مصاريف الشحــن",
                        value: "${order.shippingPrice} رس",
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
                        value: "${order.total} رس",
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
                      onTap: () {
                        controller.reOrder(orderId: order.id);
                      },
                    ),
                  ),
                  AppSpacers.width20,
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final id = await Get.toNamed(
                          Routes.ORDER_CANCEL,
                          arguments: order.id.toString(),
                        );
                        if (id != null) {
                          controller.getOrderDetails(int.parse(id));
                        }
                      },
                      child: DecoratedContainer(
                        height: 52,
                        child: Center(
                          child: Text(
                            "الغاء الطلب",
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
          );
        },
        onLoading: Padding(
          padding: AppDimension.appPadding,
          child: Column(
            children: [
              AppSpacers.height12,
              OrderInfoCardView(
                orderDate: 'الإثنـــين، 10 اكتوبر 2022م',
                orderNo: '58967895',
                status: "قيد التوصيل",
                statusNum: '',
              ).shimmer(),
              AppSpacers.height12,
              Divider(),
              AppSpacers.height12,
              OrderDetailsCardView.demmy().shimmer(),
              OrderDetailsCardView.demmy().shimmer(),
            ],
          ),
        ),
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
