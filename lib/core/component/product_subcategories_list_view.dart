import 'package:app_night_street/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategoriesListView extends GetView {
  final List<dynamic> categoriesList;
  final Function(int) onCategoryTapped;
  final String? initId;
  HomeCategoriesListView({
    Key? key,
    required this.categoriesList,
    required this.onCategoryTapped,
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
        scrollDirection: Axis.horizontal,
        child: Obx(
          () => Row(
            children: [
              categoryButton(
                isSelect: selectedId.value == '0',
                title: "الكل",
                onTap: () {
                  selectedId.value = '0';
                  onCategoryTapped(0);
                },
              ),
              ...categoriesList.map(
                (category) => categoryButton(
                  isSelect: selectedId.value == category['id'].toString(),
                  title: category['name'],
                  onTap: () {
                    selectedId.value = category['id'].toString();
                    onCategoryTapped(category['id']);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding categoryButton({
    required bool isSelect,
    required String title,
    required Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 6,
      ),
      child: InkWell(
        onTap: onTap,
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        child: Container(
          height: 43,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: isSelect
                ? AppColor.KOrangeColor.withOpacity(.1)
                : Color(0xffF9F9F9),
            border: Border.all(
              width: 1.0,
              color: isSelect ? AppColor.KOrangeColor : Color(0xffE2E4E4),
            ),
          ),
          child: Center(
            child: Text(
              '$title',
              style: TextStyle(
                fontSize: 14.0,
                color: isSelect ? AppColor.KOrangeColor : Color(0xff6C727F),
                height: 0.86,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    );
  }
}
