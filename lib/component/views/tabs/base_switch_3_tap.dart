import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';

class BaseSwitch3Tap extends StatelessWidget {
  BaseSwitch3Tap({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.Widget1,
    required this.Widget2,
    required this.Widget3,
    this.onTap,
  });

  final String title1;
  final String title2;
  final String title3;

  final Widget Widget1;
  final Widget Widget2;
  final Widget Widget3;

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
                  ],
                ),
              ),
              Expanded(
                child: KSelectItem.value == 0
                    ? Widget1
                    : KSelectItem.value == 1
                        ? Widget2
                        : Widget3,
              )
            ],
          ),
        );
      },
    );
  }
}

class BaseSwitch3TapV2 extends StatelessWidget {
  BaseSwitch3TapV2({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.Widget1,
    required this.Widget2,
    required this.Widget3,
  });

  final String title1;
  final String title2;
  final String title3;

  final Widget Widget1;
  final Widget Widget2;
  final Widget Widget3;

  final KSelectItem = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
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
                ],
              ),
            ),
            Expanded(
              child: KSelectItem.value == 0
                  ? Widget1
                  : KSelectItem.value == 1
                      ? Widget2
                      : Widget3,
            )
          ],
        );
      },
    );
  }
}
