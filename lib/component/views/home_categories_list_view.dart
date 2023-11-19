import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';

class HomeCategoriesListView extends GetView {
  final List<dynamic> categoriesList;
  final Function(int) onCategoryTapped;
  HomeCategoriesListView({
    Key? key,
    required this.categoriesList,
    required this.onCategoryTapped,
  }) : super(key: key);
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
            child: Text(
              '$title',
              style: TextStyle(
                fontSize: 14.0,
                color: isSelect ? Colors.white : Colors.black,
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
