
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/address/list_addresses/controllers/delivery_addresses_controller.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/custom_drop_menu_view.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/custom_toggle_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/add_new_address_controller.dart';

class AddNewAddressView extends GetView<AddNewAddressController> {
  final formKey = GlobalKey<FormState>();

  final specialController = TextEditingController();

  //String? cityId = dataCity.elementAt(0)["id"].toString();
  String? cityId = "-1";

  final addressController = TextEditingController();

  final phoneController = TextEditingController(
    text: Get.find<AuthenticationController>().userData!.phone.toString(),
  );

  int isDefault = 0;

  RxInt IsSelect = 0.obs;
  //String selectAddressCategory = "المنزل";

  AddNewAddressController controller = Get.put(AddNewAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx((snapshot) {
        return BaseScaffold(
          appBar: CustomAppBar(
            titleText: 'إضافة عنوان جديد',
          ),
          body: Form(
            key: formKey,
            child: ListView(
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
                TextFieldComponent.text(
                  outLineText: "علامه مميزه",
                  controller: specialController,
                ),
                AppSpacers.height25,
                SelectorView(
                  title: "اختيار المدينه",
                  defaultValue: "اختيار المدينه",
                  dataList: dataCity,
                  onChanged: (data) {
                    cityId = data['id'].toString();
                  },
                ),
                AppSpacers.height25,
                TextFieldComponent.address(
                  //outLineText: "العنوان",
                  controller: addressController,
                ),
                AppSpacers.height25,
                TextFieldComponent.phone(
                  controller: phoneController,
                  iconPath: '',
                ),
                AppSpacers.height16,
                customToggle()
              ],
            ),
          ),
          bottomBarHeight: 143,
          bottomNavigationBar: Padding(
            padding: AppDimension.appPadding,
            child: CustomBtnCompenent.main(
              text: "حفظ",
              onTap: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                if (cityId == "-1") {
                  AppDialogs.showToast(message: "برجاء اختيار المدينه");
                  return;
                }

                controller.addNewAddress(
                  cityId: cityId.toString(),
                  phone: phoneController.text.toString(),
                  address: addressController.text.toString(),
                  notes: specialController.text.toString(),
                  isDefault: isDefault.toString(),
                  email: "",
                  name: "",
                  previousRoute: (Get.arguments ?? '') as String,
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget customToggle() {
    return Row(
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
        AppSpacers.width10,
        CustomToggleView(
          activeColor: AppColors.mainColor,
          deactivateColor: Colors.white,
          Kselected: false,
          onChanged: (bool vlu) {
            if (vlu) {
              isDefault = 1;
              return;
            }
            isDefault = 0;
          },
        ),
      ],
    );
  }

  Widget customBnt({
    required String title,
    required bool isSelect,
    required String imagePath,
    required void Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 6,
      ),
      child: InkWell(
        onTap: onTap,
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        child: Container(
          height: 32.0,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: isSelect ? AppColors.mainColor : AppColors.greyColor4,
            border: Border.all(
              width: 1.0,
              color: AppColors.borderColor2,
            ),
          ),
          child: Center(
            child: Row(
              children: [
                SvgPicture.asset(
                  imagePath,
                  color: isSelect ? Colors.white : Colors.black,
                  width: 15,
                ),
                AppSpacers.width5,
                Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: isSelect ? Colors.white : AppColors.blackColor,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return InkWell(
    //   onTap: onTap,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: isSelect ? Color(0xff7D3A5B) : Colors.transparent,
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(
    //         horizontal: 10,
    //         vertical: 5,
    //       ),
    //       child: Text(
    //         "$title",
    //         style: TextStyle(
    //           color: isSelect ? Colors.white : Colors.black,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
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

class SelectorView extends GetView {
  SelectorView({
    Key? key,
    required this.dataList,
    required this.defaultValue,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  final String title;
  final String defaultValue;

  final selectedIndex = Rx<int>(0);
  final List<dynamic> dataList;
  final ValueChanged<dynamic> onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toString(),
          style: const TextStyle(
            fontSize: 16.0,
            color: AppColors.blackColor,
            letterSpacing: 0.32,
            fontWeight: FontWeight.w500,
            height: 0.75,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => InkWell(
            onTap: () {
              _showDialog(
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedIndex.value,
                  ),
                  children: List<Widget>.generate(
                    dataList.length,
                    (int index) {
                      // if (index == 0) return Center(child: Text(defaultValue));
                      return Center(child: Text(dataList[index]["name"]));
                    },
                  ),
                  onSelectedItemChanged: (int selectedItemIndex) {
                    selectedIndex.value = selectedItemIndex;
                    onChanged(dataList[selectedItemIndex]);
                  },
                ),
              );
            },
            child: Container(
              height: 52.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.greyColor2,
              ),
              child: Row(
                children: [
                  AppSpacers.width20,
                  Text(
                    dataList[selectedIndex.value]["name"],
                    style: TextStyle(
                      fontFamily: 'Effra',
                      fontSize: 16.0,
                      color: AppColors.greyColor,
                      letterSpacing: 0.32,
                      height: 0.75,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}



/*
 Obx selectAdressCategory() {
    return Obx(() {
      return Row(
        children: [
          customBnt(
            title: "المنزل",
            imagePath: AppSvgAssets.homeIcon,
            isSelect: (IsSelect.value == 0),
            onTap: () {
              IsSelect.value = 0;
              selectAddressCategory = "المنزل";
            },
          ),
          customBnt(
            title: "العمل",
            imagePath: AppSvgAssets.workIcon,
            isSelect: IsSelect.value == 1,
            onTap: () {
              IsSelect.value = 1;
              selectAddressCategory = "العمل";
            },
          ),
          customBnt(
            title: "العائلة",
            imagePath: AppSvgAssets.familyIcon,
            isSelect: IsSelect.value == 2,
            onTap: () {
              IsSelect.value = 2;
              selectAddressCategory = "العائلة";
            },
          ),
          customBnt(
            title: "الاستراحة",
            imagePath: AppSvgAssets.restIcon,
            isSelect: IsSelect.value == 3,
            onTap: () {
              IsSelect.value = 3;
              selectAddressCategory = "الاستراحة";
            },
          ),
        ],
      );
    });
  }
*/