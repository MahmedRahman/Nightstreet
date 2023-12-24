import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/component/meal_counter.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdditionsListView extends GetView {
  final List<dynamic> categoriesList;
  final Function(int) onSelected;
  final Function(int) onCounterChanged;
  final String? initId;
  AdditionsListView({
    Key? key,
    required this.categoriesList,
    required this.onSelected,
    required this.onCounterChanged,
    this.initId,
  }) {
    if (initId != null || initId != '') {
      selectedId.value = initId ?? '0';
    }
  }
  final RxString selectedId = '0'.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: categoriesList
                .map(
                  (category) => additionItem(
                    isSelect: selectedId.value == category['id'].toString(),
                    title: category['title'],
                    onTap: () {
                      selectedId.value = category['id'].toString();
                      onSelected(category['id']);
                    },
                    onCounterChanged: onCounterChanged,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Padding additionItem({
    required bool isSelect,
    required String title,
    required Function()? onTap,
    required Function(int) onCounterChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: InkWell(
        onTap: onTap,
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(22.0),
                border: Border.all(
                  width: 1.0,
                  color: AppColor.KOrangeColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: CircleAvatar(
                  backgroundColor:
                      isSelect ? AppColor.KOrangeColor : Colors.transparent,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'بيبسي حجم كبير',
                  style: TextStyles.font12regularBlack,
                ),
                const SizedBox(height: 5),
                Text(
                  '12 جنيه',
                  style: TextStyles.font12regularBlack,
                ),
              ],
            ),
            const Spacer(),
            MealCounter(
              enabled: isSelect,
              onCounterChanged: onCounterChanged,
            ),
          ],
        ),
      ),
    );
  }
}
