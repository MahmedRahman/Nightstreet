import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/custom_back_button.dart';
import 'package:app_night_street/core/component/payment_methods.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: _buildAppBar(),
      child: ListView(
        padding: AppDimension.appPadding.copyWith(top: 40),
        children: [
          Container(
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                _orderInfo(
                  orderNo: "#001158",
                  orderPrice: '1200',
                  productCount: '15',
                ),
                const SizedBox(height: 18),
                _orderDateAndStatus(
                  orderDate: "2022-08-22 12:44:16",
                  orderStatus: 'جديد',
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Text(
            'عناوين التوصيل',
            style: TextStyles.font14mediumBlack,
          ),
          SizedBox(height: 16),
          _address(
            address: 'منوف شارع مجلس المدينة ، عمارة ٤ب',
          ),
          SizedBox(height: 25),
          Text(
            'طريقة االدفع',
            style: TextStyles.font14mediumBlack,
          ),
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: PaymentMethod(
              isSelected: true,
              title: 'البطاقة الائتمانية',
              mainIcon: '',
              extraIcons: [
                "images/svg/mada.svg",
                "images/svg/visa.svg",
                "images/svg/master.svg",
              ],
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }

  Container _address({
    required String address,
  }) {
    return Container(
      height: 67,
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titleWidget(title: 'المنزل'),
          value(
            value: address,
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          CustomBackButton(
            backGroundColor: const Color(0x0f6c727f),
          ),
          const SizedBox(width: 10),
          Text(
            'تفاصيل الطلب',
            style: TextStyles.font14mediumBlack,
          )
        ],
      ),
      actions: [
        Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset("images/svg/support_icon.svg"),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

  Text value({required String value}) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        color: const Color(0xff2d2e49),
      ),
      textAlign: TextAlign.right,
      softWrap: false,
    );
  }

  Text titleWidget({required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 11,
        color: const Color(0xffababb7),
      ),
      textAlign: TextAlign.right,
      softWrap: false,
    );
  }

  Widget _orderInfo({
    required String orderNo,
    required String productCount,
    required String orderPrice,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            titleWidget(title: 'رقم الطلب'),
            const SizedBox(height: 7),
            value(value: orderNo)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget(title: 'عدد المنتجات'),
            const SizedBox(height: 7),
            value(value: "$productCount منتج")
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget(
              title: 'السعر',
            ),
            const SizedBox(height: 7),
            value(
              value: '$orderPrice جنيه',
            )
          ],
        )
      ],
    );
  }

  Widget _orderDateAndStatus({
    required String orderDate,
    required String orderStatus,
  }) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget(title: 'تاريخ الطلب'),
            const SizedBox(height: 7),
            value(value: orderDate)
          ],
        ),
        const Spacer(),
        Container(
          height: 31,
          width: 98,
          decoration: BoxDecoration(
            color: const Color(0x1ef26404),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              orderStatus,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 11,
                color: const Color(0xfff26404),
                height: 1,
              ),
              textAlign: TextAlign.right,
              softWrap: false,
            ),
          ),
        )
      ],
    );
  }
}
