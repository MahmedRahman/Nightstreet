import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:validator/validator.dart';

class TextFieldComponent extends StatefulWidget {
  final String? outLineText;
  final String hintText;
  final String iconPath;
  final TextInputType? keyboardType;

  final String? Function(String?)? validator;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController controller;
  final TextInputAction? textInputAction;

  final bool isRequired;
  final bool isReadOnly;
  final int maxLines;
  final FocusNode? focusNode;

  const TextFieldComponent({
    super.key,
    this.outLineText,
    required this.iconPath,
    required this.hintText,
    required this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    required this.controller,
    this.validator,
    this.textInputAction,
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
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
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
    this.focusNode,
    this.textInputAction,
    this.onSubmitted,
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
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
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
    this.onSubmitted,
    this.textInputAction,
    this.focusNode,
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
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
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
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
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
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
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
            IsBetween(
              min: 5,
              max: 30,
              message: "يجب ان يكون العنوان - على الاقل 5 حروف",
            ),
          ],
        );

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();

  static OutlineInputBorder get outlineInputBorder => OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(
          10,
        ),
      );
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  FocusNode? focusNode;
  @override
  void dispose() {
    widget.focusNode!.dispose();
    _removeHintOverlay();
    super.dispose();
  }

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.outLineText != '')
            Text(
              widget.outLineText ?? '',
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
          Focus(
            canRequestFocus: false,
            onFocusChange: (hasFocus) {
              if (widget.keyboardType == TextInputType.number ||
                  widget.keyboardType == TextInputType.phone) {
                if (hasFocus) {
                  return _insertHintOverlay(
                    context: context,
                    hint: widget.outLineText ?? '',
                    keyboardType: widget.keyboardType,
                    onTextTapped: () {
                      if (widget.onSubmitted != null) {
                        widget.onSubmitted!("");
                        return;
                      }
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  );
                }
                _removeHintOverlay();
              }
            },
            child: TextFormField(
              onTap: widget.onTap,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.greyColor,
              ),
              inputFormatters: widget.inputFormatters,
              maxLines: widget.maxLines,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              cursorColor: AppColors.mainColor,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onSubmitted,
              validator: widget.validator,
              focusNode: widget.focusNode,
              readOnly: widget.isReadOnly,
              textInputAction: widget.textInputAction,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: widget.maxLines > 1 ? 20 : 0,
                  ),
                  border: TextFieldComponent.outlineInputBorder,
                  enabledBorder: TextFieldComponent.outlineInputBorder,
                  focusedBorder: TextFieldComponent.outlineInputBorder,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    fontSize: 16.0,
                    color: AppColors.greyColor,
                    height: 0.75,
                  ),
                  fillColor: const Color(0xffF5F6FA),
                  filled: true,
                  prefixIcon: widget.iconPath != ''
                      ? Container(
                          padding: EdgeInsets.all(
                            size.width * .04,
                          ),
                          child: SvgPicture.asset(
                            widget.iconPath,
                            fit: BoxFit.fitHeight,
                            width: 20,
                            height: 20,
                          ),
                        )
                      : null),
            ),
          ),
        ],
      ),
    );
  }
}

OverlayEntry? _overlayEntry;

void _insertHintOverlay({
  required BuildContext context,
  required String hint,
  required TextInputType? keyboardType,
  required Function()? onTextTapped,
}) {
  _removeHintOverlay();
  final overlay = Overlay.of(context);

  final _hintFooter = PreferredSize(
    child: SizedBox(
      height: 40,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 33.0, sigmaY: 33.0),
          child: keyboardType == TextInputType.number ||
                  keyboardType == TextInputType.phone
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: onTextTapped,
                      child: Text(
                        'التالي',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(hint),
                    ),
                    const SizedBox(width: 20),
                  ],
                ).paddingSymmetric(horizontal: 22)
              : Center(
                  child: Text(hint),
                ),
        ),
      ),
    ),
    preferredSize: const Size.fromHeight(40),
  );
  _overlayEntry = OverlayEntry(
    builder: (context) {
      return KeyboardVisibilityBuilder(
        builder: (p0, isKeyboardVisible) => Positioned(
          left: 0,
          right: 0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          child: Material(
            color: Colors.transparent,
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.ease,
                  child: _hintFooter,
                  height:
                      isKeyboardVisible ? _hintFooter.preferredSize.height : 0,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  overlay.insert(_overlayEntry!);
}

void _removeHintOverlay() {
  _overlayEntry?.remove();
  _overlayEntry = null;
}
