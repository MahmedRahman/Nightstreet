import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/splash/splash_page.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/services/static_page_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_launcuer.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class AboutUsPage extends StatelessWidget {
  final staticPageService = Get.find<StaticPageService>();

  AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: "عن التطبيق",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Html(
              data: AppGlobal.KSettingData["about_application"]
                  ["desc"] //staticPageService.aboutApplication.toString(),
              ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 190,
        child: Padding(
          padding: AppDimension.appPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Text(
                'تابعنا على منصات التواصل الإجتماعي',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                  letterSpacing: 0.32,
                  fontWeight: FontWeight.w500,
                  height: 2.19,
                ),
                textAlign: TextAlign.right,
              ),
              AppSpacers.height19,
              Row(
                children: [
                  _socialMediaButton(
                    socialMediaLink: AppGlobal.KSettingData['facebook'],
                    socialMediaIcon: AppSvgAssets.facebookIcon,
                    onTap: () {
                      print(AppGlobal.KSettingData['facebook']);
                      urlLauncher(AppGlobal.KSettingData['facebook']);
                    },
                  ),
                  _socialMediaButton(
                    socialMediaLink: AppGlobal.KSettingData['twitter'],
                    socialMediaIcon: AppSvgAssets.twitterIcon,
                    onTap: () {
                      print(AppGlobal.KSettingData['twitter']);
                      urlLauncher(AppGlobal.KSettingData['twitter']);
                    },
                  ),
                  _socialMediaButton(
                    socialMediaLink: AppGlobal.KSettingData['whatsapp'],
                    socialMediaIcon: AppSvgAssets.whatsappIcon,
                    onTap: () {
                      print(AppGlobal.KSettingData['whatsapp']);
                      urlLauncher(AppGlobal.KSettingData['whatsapp']);
                    },
                  ),
                  _socialMediaButton(
                    socialMediaLink: AppGlobal.KSettingData['linkedin'],
                    socialMediaIcon: AppSvgAssets.linkedInIcon,
                    onTap: () {
                      print(AppGlobal.KSettingData['linkedin']);
                      urlLauncher(AppGlobal.KSettingData['linkedin']);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialMediaButton({
    required String socialMediaLink,
    required String socialMediaIcon,
    required void Function()? onTap,
  }) {
    return Visibility(
      visible: socialMediaLink != '',
      child: GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          socialMediaIcon,
        ),
      ).paddingOnly(
        left: 10,
      ),
    );
  }
}
