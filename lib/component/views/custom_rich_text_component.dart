import 'package:flutter/material.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class CustomRichText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback onSecondTextTapped;
  final MainAxisAlignment? mainAxisAlignment;

  const CustomRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onSecondTextTapped,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            children: <Widget>[
              Text(
                firstText,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: AppColors.greyColor,
                  height: 0.67,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacers.width5,
              InkWell(
                onTap: onSecondTextTapped,
                child: Text(
                  secondText,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    height: 0.67,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
