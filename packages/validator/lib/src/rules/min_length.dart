import '../text_validation_rule.dart';

class MinLength extends TextValidationRule {
  MinLength({
    required this.minLength,
    this.message,
  }) : super(message);

  final String? message;
  final int minLength;
  @override
  bool isValid(String input) => isValidWithMinLength(input, minLength);

  @override
  String? get errorMessage =>
      message ?? 'يجب ان يكون النص اكبر من او يساوي $minLength';
}

bool isValidWithMinLength(String input, int minLength) {
  return input.length <= minLength;
}
