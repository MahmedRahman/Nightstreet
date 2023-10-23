import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:validator/validator.dart';

class CouponForm extends StatelessWidget {
  final Function(String) onTap;
  CouponForm({
    super.key,
    required this.onTap,
  });

  final formKey = GlobalKey<FormState>();
  final coupunController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: DecoratedContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 16,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppSvgAssets.couponIcon),
                  AppSpacers.width10,
                  const Text(
                    'لديك كود ترويجي',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.blackColor,
                      letterSpacing: 0.16,
                      height: 0.75,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              AppSpacers.height29,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: coupinTextField(
                      onChanged: (String value) {},
                    ),
                  ),
                  AppSpacers.width10,
                  Expanded(
                    child: CustomBtnCompenent.main(
                      text: "تطبيق",
                      height: 45,
                      onTap: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        onTap.call(coupunController.text);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget coupinTextField({
    required ValueChanged<String>? onChanged,
  }) {
    OutlineInputBorder outlineInputBorder() => OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor2),
          borderRadius: BorderRadius.circular(
            10,
          ),
        );

    return TextFormField(
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.greyColor,
      ),
      controller: coupunController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      cursorColor: AppColors.mainColor,
      onChanged: onChanged,
      validator: customValidator(
        rules: [
          IsRequired(message: 'حقل مطلوب'),
        ],
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        border: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        errorBorder: outlineInputBorder(),
        focusedErrorBorder: outlineInputBorder(),
        hintText: 'أدخل الكود الترويجي',
        hintStyle: const TextStyle(
          fontSize: 16.0,
          color: AppColors.greyColor,
          height: 0.75,
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
