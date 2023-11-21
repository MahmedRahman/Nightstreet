import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/splash/splash_page.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/tabs/base_switch_tap.dart';
import 'package:krzv2/services/static_page_service.dart';
import 'package:krzv2/utils/app_dimens.dart';

class TermsPageService extends GetxService {}

class TermsPage extends StatelessWidget {
  TermsPage({super.key});
  final staticPageService = Get.find<StaticPageService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: "سياسة الخصوصية",
      ),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            BaseSwitchTap(
              title1: 'سياسة الاستخدام',
              title2: 'سياسة الخصوصية',
              Widget1: AppGlobal.KSettingData["usage"] == null
                  ? Center(child: Text('لا توجد بيانات'))
                  : Terms(
                      data: AppGlobal.KSettingData["usage"]["desc"],
                    ),
              Widget2: AppGlobal.KSettingData["privacy"] == null
                  ? Center(child: Text('لا توجد بيانات'))
                  : Terms(
                      data: AppGlobal.KSettingData["privacy"]["desc"],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Terms extends StatelessWidget {
  const Terms({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: data.isEmpty
          ? const Center(
              child: CircularProgressIndicator(), // Still loading
            )
          : Html(
              data: data.toString(),
            ),
    );
  }
}
