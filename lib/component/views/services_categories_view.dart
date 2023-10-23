import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_service_categories.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/utils/app_colors.dart';

class ServicesCategoriesView extends GetView {
  ServicesCategoriesView({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function(int selectedCategoryId) onTap;
  final RxInt selectedCategoryId = 0.obs;
  final serviceCategoriesController = Get.put(ServiceCategoriesController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: serviceCategoriesController.obx(
        (servicesList) {
          final serviceList = servicesList as List;
          return Obx(
            () => Row(
              children: [
                categoryButton(
                  isSelect: selectedCategoryId.value == 0,
                  title: "الكل",
                  onTap: () {
                    selectedCategoryId.value = 0;
                    onTap(0);
                  },
                ),
                ...serviceList.map(
                  (service) => categoryButton(
                    isSelect: selectedCategoryId.value == service['id'],
                    title: service['name'],
                    onTap: () {
                      selectedCategoryId.value = service['id'];
                      onTap(service['id']);
                    },
                  ),
                )
              ],
            ),
          );
        },
        onLoading: Row(
          children: [
            categoryButton(
              title: "الكل",
              isSelect: true,
              onTap: () {},
            ),
            categoryButton(
              title: "عمليات",
              isSelect: false,
              onTap: () {},
            ),
            categoryButton(
              title: "ليــــزر",
              isSelect: false,
              onTap: () {},
            ),
          ],
        ).shimmer(),
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
