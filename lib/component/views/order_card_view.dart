import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/order_info_card_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class OrderCardView extends GetView {
  const OrderCardView({
    Key? key,
    required this.orderNo,
    required this.orderDate,
    required this.status,
    required this.statusNum,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  final String orderNo;
  final String orderDate;
  final String status;
  final String statusNum;

  final String price;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: DecoratedContainer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderInfoCardView(
                orderDate: orderDate,
                orderNo: orderNo,
                status: status,
                statusNum: statusNum,
              ),
              AppSpacers.height12,
              Divider(),
              AppSpacers.height12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoCard(
                    title: "المجموع",
                    value: '$price ر.س',
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: AppColors.greyColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column InfoCard({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.greyColor,
            letterSpacing: 0.28,
            height: 0.86,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height10,
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Effra',
            fontSize: 14.0,
            color: AppColors.mainColor,
            letterSpacing: 0.28,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
