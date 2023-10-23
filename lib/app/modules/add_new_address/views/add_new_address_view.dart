import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/custom_drop_menu_view.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/custom_toggle_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/add_new_address_controller.dart';

class AddNewAddressView extends GetView<AddNewAddressController> {
  AddNewAddressView({Key? key}) : super(key: key);

  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(titleText: 'إضافة عنوان جديد'),
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          AppSpacers.height25,
          Text(
            'حدد الموقع المراد التوصيل له',
            style: TextStyle(
              fontFamily: 'Effra',
              fontSize: 16.0,
              color: AppColors.greyColor,
              letterSpacing: 0.32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          citySelector(
            onCityChanged: (String) {},
          ),
          AppSpacers.height25,
          TextFieldComponent.address(
            controller: addressController,
          ),
          AppSpacers.height25,
          TextFieldComponent.phone(
            controller: phoneController,
            iconPath: '',
          ),
          AppSpacers.height10,
          Row(
            children: [
              Text(
                'افتراضي',
                style: TextStyle(
                  fontSize: 14.0,
                  color: AppColors.blackColor,
                  letterSpacing: 0.28,
                  height: 0.86,
                ),
                textAlign: TextAlign.right,
              ),
              AppSpacers.width5,
              CustomToggleView(
                activeColor: AppColors.mainColor,
                deactivateColor: Colors.white,
                onChanged: (bool vlu) {},
              ),
            ],
          )
        ],
      ),
      bottomBarHeight: 143,
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding,
        child: CustomBtnCompenent.main(
          text: "حفظ",
          onTap: () async {
            AppDialogs.loginSuccess();
            await Future.delayed(
              const Duration(seconds: 2),
              () => Get.offAndToNamed(Routes.LAYOUT),
            );
          },
        ),
      ),
    );
  }

  CustomDropMenuView<String> citySelector({
    required Function(String) onCityChanged,
  }) {
    return CustomDropMenuView<String>(
      requiredFiled: true,
      labelText: "اختر المدينة",
      itemAsString: (String? u) => u!,
      items: ['الرياض', 'جده', 'الدمام'],
      onChanged: (String? selectedCity) {
        onCityChanged(selectedCity ?? '');
      },
      dropdownBuilder: (_, String? title) {
        return Text(
          title ?? "اختر المدينة",
          style: title == ''
              ? null
              : TextStyle(
                  fontSize: 16.0,
                  color: AppColors.greyColor,
                ),
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
              color: AppColors.greyColor,
            ),
          ),
        );
      },
    );
  }
}
