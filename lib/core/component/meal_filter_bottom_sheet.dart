import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/component/orange_bottom.dart';
import 'package:app_night_street/core/component/radio_btn_component.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealFilterBottomSheet extends GetView {
  final List<dynamic> filtersList;
  final Function(int) onSelected;

  final int? initId;
  MealFilterBottomSheet({
    Key? key,
    required this.filtersList,
    required this.onSelected,
    this.initId,
  }) {
    if (initId != null || initId != '') {
      selectedId.value = initId ?? 0;
    }
  }
  final RxInt selectedId = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 435,
      padding: AppDimension.appPadding.copyWith(
        top: 20,
      ),
      width: context.width,
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final filter = filtersList[index];
                  return Obx(
                    () => additionItem(
                      isSelect: selectedId.value == filter['id'],
                      title: filter['title'],
                      onTap: () {
                        selectedId.value = int.parse(filter['id'].toString());
                        print('selectedId.value ${selectedId.value}');
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(),
                    ),
                itemCount: filtersList.length),
          ),
          confirmAndCancelBtn(
            onConfimTapped: () {
              // onSelected(selectedId.value);
              Get.back();
            },
            onCancelTapped: () {
              selectedId.value = -1;
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Padding confirmAndCancelBtn({
    required Function() onConfimTapped,
    required Function() onCancelTapped,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: OrangeBtn(
              title: "تطبيق",
              onTap: onConfimTapped,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButton.fill(
              title: "اعادة تعيين",
              textStyleColor: Colors.white,
              borderRadius: 32,
              backgroundColor: Color(0xffDBDDE0),
              borderSideColor: Color(0xffDBDDE0),
              onPressed: () => onCancelTapped(),
            ),
          ),
        ],
      ),
    );
  }

  Widget additionItem({
    required bool isSelect,
    required String title,
    required Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.font12regularBlack,
          ),
          const Spacer(),
          RadioBtn(
            isSelected: isSelect,
          ),
        ],
      ),
    );
  }
}
