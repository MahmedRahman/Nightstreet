import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/additions_list_view.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/component/meal_counter.dart';
import 'package:app_night_street/core/component/meal_delivery_time.dart';
import 'package:app_night_street/core/component/meal_name_and_rate.dart';
import 'package:app_night_street/core/component/orange_bottom.dart';
import 'package:app_night_street/core/component/size_selector.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MealInfo extends StatelessWidget {
  const MealInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: AppDimension.appPadding.copyWith(top: 20),
        children: [
          MealNameAndRate(
            name: 'عرض وجبة الصحاب',
            rate: '4.9',
          ),
          const SizedBox(height: 14),
          MealDeliveryTime(
            time: '25 - 20 دقيقة',
          ),
          const SizedBox(height: 21),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '340 جنيه',
                style: TextStyles.font12regularBlack,
                textAlign: TextAlign.right,
              ),
              MealCounter(
                onCounterChanged: (int counter) {},
              ),
            ],
          ),
          const SizedBox(height: 21),
          Container(
            width: Get.width,
            height: 1,
            color: AppColor.KdividerColor,
          ),
          const SizedBox(height: 16),
          Text(
            'إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.',
            style: TextStyles.font12regularBlack,
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          Container(
            width: Get.width,
            height: 1,
            color: AppColor.KdividerColor,
          ),
          const SizedBox(height: 21),
          SizeSelector(
            onSizedChanged: (String) {},
          ),
          const SizedBox(height: 10),
          Container(
            width: Get.width,
            height: 1,
            color: AppColor.KdividerColor,
          ),
          const SizedBox(height: 21),
          Text(
            'اختر الحجم',
            style: TextStyles.font14mediumBlack,
            textAlign: TextAlign.right,
            softWrap: false,
          ),
          const SizedBox(height: 14),
          AdditionsListView(
            categoriesList: [
              {
                "id": 1,
                "title": "بيبسي حجم كبير",
                "price": "12 جنيه",
              },
              {
                "id": 2,
                "title": "بيبسي حجم كبير",
                "price": "12 جنيه",
              },
            ],
            onSelected: (int id) {},
            onCounterChanged: (int counter) {},
          )
        ],
      ),
      bottomNavigationBar: addToCartBtnAndPrice(
        price: '2000',
        onAddToCartTapped: () {},
      ),
    );
  }

  Container addToCartBtnAndPrice({
    required String price,
    required Function onAddToCartTapped,
  }) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1a000000),
            offset: Offset(0, 10),
            blurRadius: 60,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: OrangeBtn(
                title: 'اضف الي العربة',
                iconPath: "images/svg/white_cart_icon.svg",
                onTap: () => onAddToCartTapped(),
              ),
            ),
          ),
          Row(
            children: [
              SvgPicture.asset("images/svg/price_icon.svg"),
              const SizedBox(width: 6),
              Text(
                '$price جنيه',
                style: TextStyles.font16regularBlack2,
              ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class TextSTyles {}
