import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_check_view.dart';
import 'package:krzv2/component/views/rating_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/about_doctor_controller.dart';

var dummyText =
    "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم";

class AboutDoctorView extends GetView<AboutDoctorController> {
  const AboutDoctorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'عن الطبيب',
      ),
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          AppSpacers.height19,
          doctorInfo(),
          AppSpacers.height16,
          Divider(),
          AppSpacers.height16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'عن الطبيب :',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                  height: 0.75,
                ),
                textAlign: TextAlign.right,
              ),
              Text(
                dummyText,
                style: TextStyle(
                  fontFamily: 'Effra',
                  fontSize: 14.0,
                  color: AppColors.blackColor,
                  letterSpacing: 0.21,
                  height: 2.5,
                ),
              ),
              AppSpacers.height25,
              doctorPoint(),
              doctorPoint(),
              doctorPoint(),
              doctorPoint(),
              doctorPoint(),
              doctorPoint(),
              doctorPoint(),
              doctorPoint(),
            ],
          )
        ],
      ),
    );
  }

  Widget doctorPoint() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          CustomCheckView(
            backgroundColor: AppColors.borderColor2,
            iconColor: AppColors.greyColor,
          ),
          SizedBox(
            width: 8,
          ),
          Text("خلافاَ للإعتقاد السائد فإن لوريم إيبسوم ليس نصاَ عشوائياً"),
        ],
      ),
    );
  }

  Widget doctorInfo() {
    return DecoratedContainer(
      child: Column(
        children: [
          AppSpacers.height19,
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: CashedNetworkImageView(
              imageUrl:
                  'https://cdn.vectorstock.com/i/1000x1000/78/32/male-doctor-with-stethoscope-avatar-vector-31657832.webp',
            ),
          ),
          AppSpacers.height10,
          Text(
            'حسين محمد',
            style: TextStyle(
              fontSize: 18.0,
              color: AppColors.blackColor,
              letterSpacing: 0.45,
              height: 1.06,
            ),
            textAlign: TextAlign.right,
          ),
          AppSpacers.height10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'جراحة أسنان',
                style: TextStyle(
                  fontFamily: 'Effra',
                  fontSize: 14.0,
                  color: AppColors.greyColor,
                  letterSpacing: 0.21,
                  height: 0.86,
                ),
                textAlign: TextAlign.right,
              ),
              AppSpacers.width10,
              Container(
                height: 20,
                width: 2,
                color: AppColors.greyColor,
              ),
              AppSpacers.width10,
              RatingBarView(
                initRating: 4,
                totalRate: 4,
              ),
            ],
          ),
          AppSpacers.height19,
        ],
      ),
    );
  }
}
