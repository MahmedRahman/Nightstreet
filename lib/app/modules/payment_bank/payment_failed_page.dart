import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class PaymentFailedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppSvgAssets.failedIcon,
            
              color: AppColors.mainColor,
              height: 100,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'حدث خطاء ما !!',
              style: TextStyle(
                fontFamily: 'Effra',
                fontSize: 18.0,
                letterSpacing: 0.9,
                fontWeight: FontWeight.w500,
                height: 0.56,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "خطاء في عمليه الدفع الالكتروني",
              style: TextStyle(
                fontFamily: 'Effra',
                fontSize: 16.0,
                letterSpacing: 0.24,
                height: 2.19,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: CustomBtnCompenent.main(
                text: "الرئيسية",
                onTap: () {
                  Get.offAllNamed(Routes.LAYOUT);
                },
              ),
            )
          ],
        ),
      ),
    );
  
  
  }
}
