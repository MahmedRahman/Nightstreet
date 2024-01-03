import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/terms_controller.dart';

class TermsView extends GetView<TermsController> {
  const TermsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: CustomAppBar(titleText: "شروط الاستخدام"),
      child: ListView(
        padding: AppDimension.appPadding.copyWith(top: 40),
        children: [
          Text(
            'تعرف صفحة الشروط والأحكام الخاصة بنا المستخدمين بشروط المتجر وأحكامه حتى يتبع المستخدمين هذه الشروط ويتجنبوا مخالفة تلك الشروط والأحكام ,\n\nلأن مخالفة شروط وأحكام المتجر تعرض صاحب المخالفة للحظر من استخدام المتجر.',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: const Color(0xff2d2e49),
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 40),
          Text(
            'المستخدم للمتجر ملتزم بـالتالي :\n      ﻿1- أن يحافظ  على سلامة المتجر من أي ضرر ولا يفعل أي شيء من شأنه التسبب بأي ضرر لمتجرنا.\n\n      2- أن يخبرنا على الفور في حالة حدوث أن شيء يهدد حسابه بمتجرنا أو حدوث كشف لكلمة السر الخاصة به من طرف شخص أخر.\n\n      3- أن يقدم كافة الضمانات التي يطلبه منه متجرنا لكي يقوم بإنشاء حساب تاجر.\n\n      4- من الممكن أن تلجأ إدارة متجرنا إلى تعديل أو تغيير بعض الشروط الموجودة بصفحة الشروط والأحكام الخاصة بنا في أي وقت رأينا أنه من الضروري عمل ذلك.\n\n      5- يلتزم كافة الأطراف بالعمل على حل أي مشكلة تقع بالمتجر بالطرق الودية , وإذا لم تحل المشكلة بالطرق الودية يتم اللجوء حينها للسلطة القضائية بالمملكة العربية السعودية لحل تلك المشكلة.\n\n      6- لا يحق لأي شخص لا يوافق على شروط وأحكام متجرنا أن يستخدم المتجر أو حتى خدماته.\n\n      7- لا تقع أي مسؤولية على متجرنا في حدوث ضرر لأي مستخدم موجود نتيجة لأسباب خارجة عن إرادتنا على سبيل المثال حدوث عطل بالمتجر أو حدوث عميلة نصب لأحد مستخدمي المتجر من قبل مستخدم أخر.',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: const Color(0xff2d2e49),
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
