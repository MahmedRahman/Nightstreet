import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:validator/validator.dart';

class TextFieldComponent extends StatelessWidget {
  final String? outLineText;
  final String hintText;
  final String iconPath;
  final TextInputType? keyboardType;

  final String? Function(String?)? validator;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;

  final bool isRequired;
  final bool isReadOnly;
  final int maxLines;

  const TextFieldComponent({
    super.key,
    this.outLineText,
    required this.iconPath,
    required this.hintText,
    required this.keyboardType,
    this.onChanged,
    required this.controller,
    this.validator,
    this.onTap = null,
    this.maxLines = 1,
    this.inputFormatters,
    this.isRequired = true,
    this.isReadOnly = false,
  });

  TextFieldComponent.phone({
    required this.controller,
    super.key,
    this.onChanged,
    this.isReadOnly = false,
    this.onTap = null,
    this.maxLines = 1,
    this.isRequired = true,
    this.iconPath = AppSvgAssets.phoneIcon,
  })  : outLineText = 'رقم الجوال',
        hintText = '05xxxxxxxx',
        keyboardType = TextInputType.phone,
        validator = customValidator(
          rules: [
            isRequired ? IsRequired(message: 'حقل مطلوب') : IsOptional(),
            IsSaudiPhone(),
          ],
        ),
        inputFormatters = [
          LengthLimitingTextInputFormatter(10),
        ];

  TextFieldComponent.number({
    required this.controller,
    super.key,
    this.onChanged,
    this.onTap = null,
    this.isReadOnly = false,
    this.maxLines = 1,
    this.isRequired = true,
  })  : outLineText = "ادخل مبلغ بطاقة الهدايا",
        hintText = '50 ر.س',
        keyboardType = TextInputType.number,
        iconPath = AppSvgAssets.costIcon,
        validator = customValidator(
          rules: [
            isRequired ? IsRequired(message: 'حقل مطلوب') : IsOptional(),
            // IsSaudiPhone(),
          ],
        ),
        inputFormatters = [
          LengthLimitingTextInputFormatter(10),
        ];

  TextFieldComponent.longMessage({
    required this.controller,
    required this.outLineText,
    required this.hintText,
    super.key,
    this.onChanged,
    this.isReadOnly = false,
    this.onTap = null,
    this.maxLines = 7,
    this.isRequired = true,
    this.validator,
    this.inputFormatters,
  })  : keyboardType = TextInputType.text,
        iconPath = '';

  TextFieldComponent.name({
    super.key,
    this.onChanged,
    required this.controller,
    this.inputFormatters,
    this.maxLines = 1,
    this.onTap = null,
    this.isReadOnly = false,
    this.isRequired = true,
  })  : outLineText = "الإسـم بالكامل",
        hintText = "ادخل الإسـم بالكامل",
        keyboardType = TextInputType.name,
        iconPath = AppSvgAssets.userIcon,
        validator = customValidator(
          rules: [
            isRequired ? IsRequired(message: 'حقل مطلوب') : IsOptional(),
            IsBetween(min: 3, max: 30),
            IsEnglishArabicChar(),
          ],
        );

  TextFieldComponent.text({
    super.key,
    this.onChanged,
    required this.controller,
    this.onTap = null,
    this.inputFormatters,
    this.maxLines = 1,
    this.isReadOnly = false,
    this.isRequired = true,
    this.outLineText,
  })  : hintText = "ادخل النص",
        keyboardType = TextInputType.name,
        iconPath = AppSvgAssets.userIcon,
        validator = customValidator(
          rules: [
            isRequired ? IsRequired(message: 'حقل مطلوب') : IsOptional(),
            IsBetween(min: 3, max: 30),
            IsEnglishArabicChar(),
          ],
        );

  TextFieldComponent.email({
    super.key,
    this.onChanged,
    required this.controller,
    this.inputFormatters,
    this.onTap = null,
    this.iconPath = '',
    this.maxLines = 1,
    this.isReadOnly = false,
    this.isRequired = true,
  })  : outLineText = "البريد الإلكتروني (إختياري)",
        hintText = "ادخل البريد الإلكتروني",
        keyboardType = TextInputType.emailAddress,
        validator = customValidator(
          rules: [
            isRequired ? IsRequired(message: 'حقل مطلوب') : IsOptional(),
            IsEmail(),
          ],
        );

  TextFieldComponent.address({
    super.key,
    this.onChanged,
    required this.controller,
    this.inputFormatters,
    this.onTap = null,
    this.maxLines = 1,
    this.isReadOnly = false,
    this.isRequired = true,
  })  : outLineText = "العنوان",
        hintText = "ادخل تفاصيل عنوانك",
        keyboardType = TextInputType.text,
        iconPath = '',
        validator = customValidator(
          rules: [
            isRequired ? IsRequired(message: 'حقل مطلوب') : IsOptional(),
            IsBetween(min: 5, max: 30),
          ],
        );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (outLineText != '')
            Text(
              outLineText ?? '',
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColors.blackColor,
                letterSpacing: 0.32,
                fontWeight: FontWeight.w500,
                height: 0.75,
              ),
              textAlign: TextAlign.right,
            ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onTap: onTap,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.greyColor,
            ),
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: AppColors.mainColor,
            onChanged: onChanged,
            validator: validator,
            readOnly: isReadOnly,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: maxLines > 1 ? 20 : 0,
                ),
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 16.0,
                  color: AppColors.greyColor,
                  height: 0.75,
                ),
                fillColor: const Color(0xffF5F6FA),
                filled: true,
                prefixIcon: iconPath != ''
                    ? Container(
                        padding: EdgeInsets.all(
                          size.width * .04,
                        ),
                        child: SvgPicture.asset(
                          iconPath,
                          fit: BoxFit.fitHeight,
                          width: 20,
                          height: 20,
                        ),
                      )
                    : null),
          ),
        ],
      ),
    );
  }

  static OutlineInputBorder get outlineInputBorder => OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(
          10,
        ),
      );
}
