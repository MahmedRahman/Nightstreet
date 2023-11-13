import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/address/list_addresses/controllers/delivery_addresses_controller.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_drop_menu_view.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/custom_toggle_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/edit_address_controller.dart';

class editAddressView extends GetView<editAddressController> {
  final data;
  final formKey = GlobalKey<FormState>();
  final controller = Get.put(editAddressController());

  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final specialController = TextEditingController();
  final isDefaultCon = TextEditingController();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  int cityId = 0;

  editAddressView({
    required this.data,
  }) {
    Future.delayed(Duration.zero, () async {
      addressController.text = data["address"];
      phoneController.text = data["phone"];
      specialController.text = data["notes"] ?? '';
      cityId = data["city"]["id"];
      isDefaultCon.text = data["is_default"].toString();
      print("cityId ${cityId.toString()}");
      controller.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx((snapshot) {
        return BaseScaffold(
          appBar: CustomAppBar(titleText: 'تعديل العنوان'),
          body: Form(
            key: formKey,
            child: ListView(
              padding: AppDimension.appPadding,
              children: [
                AppSpacers.height16,
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
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(addressFocusNode),
                ),
                AppSpacers.height25,
                SelectorView(
                  title: "اختر المدينة",
                  selectedIndexValue: cityId,
                  dataList: dataCity,
                  onChanged: (data) {
                    cityId = data['id'];
                  },
                ),
                AppSpacers.height25,
                TextFieldComponent.address(
                  focusNode: addressFocusNode,
                  controller: addressController,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(phoneFocusNode),
                ),
                AppSpacers.height25,
                TextFieldComponent.phone(
                  controller: phoneController,
                  iconPath: '',
                  focusNode: phoneFocusNode,
                ),
                AppSpacers.height16,
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
                    AppSpacers.width10,
                    CustomToggleView(
                      activeColor: AppColors.mainColor,
                      deactivateColor: Colors.white,
                      Kselected: int.tryParse(isDefaultCon.text) == 1,
                      onChanged: (bool vlu) {
                        if (vlu) {
                          isDefaultCon.text = '1';

                          return;
                        }

                        isDefaultCon.text = '0';
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          bottomBarHeight: 143,
          bottomNavigationBar: Padding(
            padding: AppDimension.appPadding,
            child: CustomBtnCompenent.main(
              text: "تعديل",
              onTap: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                controller.editAddress(
                  Id: data["id"],
                  cityId: cityId.toString(),
                  phone: phoneController.text.toString(),
                  address: addressController.text.toString(),
                  notes: specialController.text.toString(),
                  isDefault: isDefaultCon.text.toString(),
                  previousRoute: Get.previousRoute,
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget customBnt({
    required String title,
    required bool isSelect,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelect ? Color(0xff7D3A5B) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Text(
            "$title",
            style: TextStyle(
              color: isSelect ? Colors.white : Colors.black,
            ),
          ),
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

class SelectorView extends GetView {
  final selectedIndexValue;
  final String title;
  final selectedIndex = Rx<int>(0);
  final List<dynamic> dataList;
  final ValueChanged<dynamic> onChanged;
  var selectItem = "";
  SelectorView({
    required this.dataList,
    required this.onChanged,
    required this.title,
    required this.selectedIndexValue,
  }) {
    print("val ${selectedIndexValue.toString()}");

    final city =
        dataList.where((element) => element["id"] == selectedIndexValue).first;

    final index = dataList.indexOf(city);

    print("index ${index.toString()}");

    selectedIndex.value = index;

    //selectedIndex.value = selectedIndexValue;
  }

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
                      return Center(child: Text(dataList[index]["name"]));
                    },
                  ),
                  onSelectedItemChanged: (int selectedItemIndex) {
                    selectedIndex.value = selectedItemIndex;
                    // log(selectedIndex.value.toString());
                    //log(dataList[selectedItemIndex]);

                    onChanged(dataList.elementAt(selectedItemIndex));

                    // onChanged(dataList.where((element) => element["id"] == selectedIndex.value).first);
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
                    dataList.elementAt(selectedIndex.value)["name"],
                    //dataList.where((element) => element["id"] == selectedIndex.value).first["name"],
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
