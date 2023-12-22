import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ResturantItem extends GetView {
  const ResturantItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                height: 180,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.asset(
                    "images/png/360_F_324739203_keeq8udvv0P2h1MLYJ0GLSlTBagoXS48.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                ),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset('images/svg/fill_heart.svg'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عرض وجبة الصحاب',
                  style: TextStyles.font12regularBlack,
                  textAlign: TextAlign.right,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("images/svg/start.svg"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '4.9',
                          style: TextStyles.font12regularBlack,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "images/svg/delivery-bike.svg",
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '25 - 20',
                          style: TextStyles.font12regularBlack,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'دقيقة',
                          style: TextStyles.font12regularBlack,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Image.asset(
                          "images/png/image_restrant.jpg",
                          width: 12,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '25 - 20',
                          style: TextStyles.font12regularBlack,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '340 جنيه',
                  style: TextStyles.font12regularBlack,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
