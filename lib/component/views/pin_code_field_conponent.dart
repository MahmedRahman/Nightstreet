// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:krzv2/utils/app_colors.dart';

class PinCodeField extends StatelessWidget {
  PinCodeField({
    Key? key,
    required this.onCompleted,
    required this.validator,
  }) : super(key: key);

  final ValueChanged<String>? onCompleted;
  // TextEditingController otpController = TextEditingController(text: "7418");
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FormField<String>(
        validator: (String? value) {
          final String? valid = validator!(value ?? '');

          return valid;
        },
        builder: (field) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              PinCodeTextField(
                // controller: otpController,
                enablePinAutofill: true,
                autoFocus: true,
                appContext: context,
                pastedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                length: 4,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  activeColor: AppColors.mainColor,
                  disabledColor: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 60,
                  fieldWidth: 60,
                  inactiveColor: field.hasError
                      ? AppColors.errorColor
                      : AppColors.greyColor3,
                  selectedColor: AppColors.mainColor,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.transparent,
                  activeFillColor: Colors.white,
                ),
                cursorColor: AppColors.mainColor,
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                keyboardType: TextInputType.number,
                onCompleted: (value) {
                  onCompleted!.call(value);
                },
                onChanged: (value) {
                  field.setValue(value);
                  field.validate();
                  // onChanged!.call(value);
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
              Visibility(
                visible: field.hasError,
                replacement: const SizedBox.shrink(),
                child: Text(
                  '${field.errorText}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: AppColors.errorColor,
                    height: 0.75,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
