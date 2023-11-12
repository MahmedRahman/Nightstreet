import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';

class BaseSwitchTap extends StatelessWidget {
  BaseSwitchTap(
      {required this.title1,
      required this.title2,
      required this.Widget1,
      required this.Widget2,
      this.onTap});

  final String title1;
  final String title2;

  final Widget Widget1;
  final Widget Widget2;

  final void Function(int index)? onTap;

  final KSelectItem = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      onTap: () {
                        KSelectItem.value = 0;
                        if (onTap != null) onTap!(0);
                      },
                      child: Column(
                        children: [
                          Text(
                            title1,
                            style: TextStyle(
                              fontSize: 16,
                              color: KSelectItem.value == 0
                                  ? AppColors.mainColor
                                  : AppColors.greyColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 2,
                            color: KSelectItem.value == 0
                                ? AppColors.mainColor
                                : AppColors.borderColor2,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      onTap: () {
                        KSelectItem.value = 1;
                        if (onTap != null) onTap!(1);
                      },
                      child: Column(
                        children: [
                          Text(
                            title2,
                            style: TextStyle(
                              fontSize: 16,
                              color: KSelectItem.value == 1
                                  ? AppColors.mainColor
                                  : AppColors.greyColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 2,
                            color: KSelectItem.value == 1
                                ? AppColors.mainColor
                                : AppColors.borderColor2,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: KSelectItem.value == 0 ? Widget1 : Widget2,
            )
          ],
        );
      },
    );
  }
}
