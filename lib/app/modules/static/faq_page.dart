import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/splash/splash_page.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/services/static_page_service.dart';
import 'package:krzv2/utils/app_colors.dart';

class FaqPage extends StatelessWidget {
  FaqPage({super.key});
  final staticPageService = Get.find<StaticPageService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: "الأسئلة الشائعة",
      ),
      body: (AppGlobal.KSettingData["faq"] as List).length == 0
          ? Center(child: Text('لا توجد بيانات'))
          : ListView(
              padding: AppDimension.appPadding + const EdgeInsets.only(top: 25),
              children: List.generate(
                AppGlobal.KSettingData["faq"].length,
                (index) {
                  return _FaqBuilder(
                    title:
                        AppGlobal.KSettingData["faq"][index]["name"].toString(),
                    description:
                        AppGlobal.KSettingData["faq"][index]["desc"].toString(),
                  );
                },
              ),
            ),
    );
  }
}

class _FaqBuilder extends StatelessWidget {
  const _FaqBuilder({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: AppColors.greyColor4,
            border: Border.all(
              width: 1.0,
              color: AppColors.borderColor2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: ListTileTheme(
              dense: true,
              child: ExpansionTile(
                backgroundColor: AppColors.greyColor4,
                collapsedBackgroundColor: AppColors.greyColor4,
                collapsedTextColor: Colors.black,
                textColor: AppColors.mainColor,
                iconColor: AppColors.blackColor,
                collapsedIconColor: const Color(0xffB6B6B6),
                title: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 0.24,
                    height: 0.75,
                  ),
                  textAlign: TextAlign.right,
                ),
                children: <Widget>[
                  Padding(
                    padding: AppDimension.appPadding,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 300,
                            child: Html(
                              data: description,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
