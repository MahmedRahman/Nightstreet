import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/complaint_category_selector_view.dart';
import 'package:krzv2/component/views/complant_add_attachment_btn_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/file_image_picker_action_sheet_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/complaint_category_model.dart';

import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:validator/validator.dart';

import '../controllers/complaint_add_new_controller.dart';

class ComplaintAddNewView extends GetView<ComplaintAddNewController> {
  ComplaintAddNewView({Key? key}) : super(key: key);
  final descriptionText = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final con = Get.put(ComplaintAddNewController());
  final selectedCategoryId = Rx<int?>(null);
  final selectedsubCategoryId = Rx<int?>(null);
  final selectedFile = Rx<File?>(null);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(titleText: 'إضافة شكوى جديدة'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: AppDimension.appPadding,
          children: [
            AppSpacers.height25,
            Text(
              'ادخل بيانات الشكوى',
              style: TextStyle(
                fontSize: 16.0,
                color: AppColors.greyColor,
                letterSpacing: 0.32,
              ),
            ),
            AppSpacers.height16,
            Divider(),
            AppSpacers.height25,
            controller.obx(
              (List<ComplaintCategoryModel>? categories) {
                selectedCategoryId.value = (categories ?? []).first.id;
                return ComplaintCategorySelectorView(
                  title: "الأقسام الرئيسية",
                  categoriesList: categories ?? [],
                  onChanged: (ComplaintCategoryModel value) {
                    selectedCategoryId.value = value.id;
                    controller.subCategories.value = value.subCategories;
                  },
                );
              },
              onLoading: Container(
                height: 52.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.greyColor2,
                ),
              ).shimmer(),
              onError: (String? error) => Center(
                child: Text(
                  error.toString(),
                ),
              ),
            ),
            Obx(
              () {
                if (controller.subCategories.value.isEmpty) return SizedBox();
                selectedsubCategoryId.value =
                    (controller.subCategories.value).first.id;
                return Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ComplaintCategorySelectorView(
                    title: "الأقسام الفرعية",
                    categoriesList: controller.subCategories.value,
                    onChanged: (ComplaintCategoryModel value) {
                      selectedsubCategoryId.value = value.id;
                    },
                  ),
                );
              },
            ),
            AppSpacers.height25,
            TextFieldComponent.longMessage(
              outLineText: 'تفاصيل التذكرة',
              hintText: 'اكتب تفاصيل التذكرة',
              controller: descriptionText,
              validator: customValidator(
                rules: [
                  IsRequired(message: 'حقل مطلوب'),
                  IsBetween(min: 3, max: 30),
                  IsEnglishArabicChar(),
                ],
              ),
            ),
            AppSpacers.height25,
            ComplantAddAttachmentBtnView(
              onTap: () => _selecteFileSheet(
                onSelected: (File file) {
                  selectedFile.value = file;
                  controller.update();
                },
              ),
            ),
            Obx(
              () => Visibility(
                visible: selectedFile.value != null,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "تم ارفاق ملف/صوره",
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w500,
                      height: 0.67,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            AppSpacers.height19,
          ],
        ),
      ),
      bottomBarHeight: 150,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: CustomBtnCompenent.main(
          text: 'ارسال',
          onTap: () {
            if (!formKey.currentState!.validate()) {
              return;
            }

            controller.saveComplaint(
              description: descriptionText.text.toString(),
              categoryId: selectedsubCategoryId.value != null
                  ? selectedsubCategoryId.value.toString()
                  : selectedCategoryId.value.toString(),
              file: selectedFile.value,
            );
          },
        ),
      ),
    );
  }
}

void _selecteFileSheet({
  required final Function(File) onSelected,
}) {
  showCupertinoModalPopup<void>(
    context: Get.context!,
    builder: (BuildContext context) => FileImagePickerActionSheetView(
      onSelected: onSelected,
    ),
  );
}
