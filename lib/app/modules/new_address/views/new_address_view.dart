import 'package:app_night_street/app/modules/new_address/controllers/new_address_controller.dart';
import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/component/custom_drop_menu_view.dart';
import 'package:app_night_street/core/component/rounded_text_field.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewAddressView extends GetView<NewAddressController> {
  const NewAddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: CustomAppBar(titleText: "إضافة عنوان جديد"),
      child: ListView(
        padding: AppDimension.appPadding.copyWith(
          top: 37,
        ),
        children: [
          addressTypeDropMenu(
            onTypeChanged: (String) {},
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: countryDropMenu(
                  onCountryChanged: (String) {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: cityDropMenu(
                  onCityChanged: (String) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          RoundedTextField(
            labelText: "العنوان بالتفصيل",
          ),
          const SizedBox(height: 30),
          Text(
            'أو اضف العنوان من الخريطة',
            style: TextStyles.font16RegularOrange.copyWith(
              decoration: TextDecoration.underline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding.copyWith(
          bottom: 40,
        ),
        child: CustomButton.outLine(
          onPressed: () {},
          title: "حفظ العنوان",
        ),
      ),
    );
  }

  CustomDropMenuView<String> addressTypeDropMenu({
    required Function(String) onTypeChanged,
  }) {
    return CustomDropMenuView<String>(
      requiredFiled: true,
      labelText: "نوع العنوان",
      itemAsString: (String? u) => u!,
      items: ['المنزل', 'العمل', 'البيت'],
      onChanged: (String? selectedType) {
        onTypeChanged(selectedType ?? '');
      },
      dropdownBuilder: (_, String? title) {
        return Text(
          title ?? "نوع العنوان",
          style: title == '' ? null : TextStyles.font12regularGray,
        );
      },
      popupItemBuilder: (_, String? title, __) {
        return Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: AppColor.KgrayColor,
            ),
          ),
        );
      },
    );
  }

  CustomDropMenuView<String> countryDropMenu({
    required Function(String) onCountryChanged,
  }) {
    return CustomDropMenuView<String>(
      requiredFiled: true,
      labelText: "الدولة",
      itemAsString: (String? u) => u!,
      items: ['الشرقية', 'مصر'],
      onChanged: (String? selectedType) {
        onCountryChanged(selectedType ?? '');
      },
      dropdownBuilder: (_, String? title) {
        return Text(
          title ?? "الدولة",
          style: title == '' ? null : TextStyles.font12regularGray,
        );
      },
      popupItemBuilder: (_, String? title, __) {
        return Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: AppColor.KgrayColor,
            ),
          ),
        );
      },
    );
  }

  CustomDropMenuView<String> cityDropMenu({
    required Function(String) onCityChanged,
  }) {
    return CustomDropMenuView<String>(
      requiredFiled: true,
      labelText: "المدينة",
      itemAsString: (String? u) => u!,
      items: ['مصر الجديدة', 'التجمع'],
      onChanged: (String? selectedType) {
        onCityChanged(selectedType ?? '');
      },
      dropdownBuilder: (_, String? title) {
        return Text(
          title ?? "المدينة",
          style: title == '' ? null : TextStyles.font12regularGray,
        );
      },
      popupItemBuilder: (_, String? title, __) {
        return Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: AppColor.KgrayColor,
            ),
          ),
        );
      },
    );
  }
}
