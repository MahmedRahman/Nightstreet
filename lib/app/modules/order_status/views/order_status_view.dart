import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/order_app_bar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/order_status_controller.dart';

class OrderStatusView extends GetView<OrderStatusController> {
  const OrderStatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: OrderAppBar(
        title: 'حالة الطلب',
      ),
      child: ListView(
        padding: AppDimension.appPadding.copyWith(top: 40),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              statusItem(
                statusName: 'جاري تجهيز الطلب',
                time: '12:21 PM',
                statusIcon: "images/svg/prepare_order.svg",
              ),
              dottedLine(
                color: Color(0xff5EBB5E),
              ),
              statusItem(
                statusName: 'تم استلام الطلب من قبل المندوب',
                time: '12:21 PM',
                statusIcon: "images/svg/order_in_progress.svg",
              ),
              dottedLine(
                color: Color(0xff959BA4),
              ),
              statusItem(
                statusName: 'الطلب ف الطريق اليك',
                time: '12:21 PM',
                statusIcon: "images/svg/order_wating.svg",
              ),
              dottedLine(
                color: Color(0xff959BA4),
              ),
              statusItem(
                statusName: 'طلب مكتمل',
                time: '12:21 PM',
                statusIcon: "images/svg/order_wating.svg",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding dottedLine({required Color color}) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: DottedLine(
        dashLength: 30,
        dashGapLength: 10,
        lineThickness: 2,
        dashColor: color,
        dashGapColor: Colors.transparent,
        direction: Axis.vertical,
        lineLength: 150,
      ),
    );
  }

  Row statusItem({
    required String statusName,
    required String statusIcon,
    required String time,
  }) {
    return Row(
      children: [
        SvgPicture.asset(statusIcon),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statusName,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: const Color(0xff2d2e49),
              ),
            ),
            SizedBox(height: 8),
            Text(
              time,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 11,
                color: const Color(0xffababb7),
              ),
              textAlign: TextAlign.right,
              softWrap: false,
            )
          ],
        )
      ],
    );
  }
}
