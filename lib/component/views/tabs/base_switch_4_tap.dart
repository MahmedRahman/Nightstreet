import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';

class BaseSwitch4Tap extends StatelessWidget {
  BaseSwitch4Tap({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
    required this.Widget1,
    required this.Widget2,
    required this.Widget3,
    required this.Widget4,
    this.onTap,
  });

  final String title1;
  final String title2;
  final String title3;
  final String title4;

  final Widget Widget1;
  final Widget Widget2;
  final Widget Widget3;
  final Widget Widget4;

  final void Function(int index)? onTap;

  final KSelectItem = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    Expanded(
                      child: InkWell(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        onTap: () {
                          KSelectItem.value = 2;
                          if (onTap != null) onTap!(2);
                        },
                        child: Column(
                          children: [
                            Text(
                              title3,
                              style: TextStyle(
                                fontSize: 16,
                                color: KSelectItem.value == 2
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
                              color: KSelectItem.value == 2
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
                          KSelectItem.value = 3;
                          if (onTap != null) onTap!(3);
                        },
                        child: Column(
                          children: [
                            Text(
                              title4,
                              style: TextStyle(
                                fontSize: 16,
                                color: KSelectItem.value == 3
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
                              color: KSelectItem.value == 3
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
                child: (() {
                  switch (KSelectItem.value) {
                    case 0:
                      return Widget1;
                    case 1:
                      return Widget2;
                    case 2:
                      return Widget3;
                    case 3:
                      return Widget4;
                    default:
                      return Widget3;
                  }
                })(),
              )
            ],
          ),
        );
      },
    );
  }
}
