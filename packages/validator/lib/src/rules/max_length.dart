import '../text_validation_rule.dart';

class MaxLength extends TextValidationRule {
  MaxLength({
    required this.maxLength,
    this.message,
  }) : super(message);

  final String? message;
  final int maxLength;
  @override
  bool isValid(String input) => isValidWithMaxLength(input, maxLength);

  @override
  String? get errorMessage =>
      message ?? 'يجب ان يكون النص اقل من او يساوي $maxLength';
}

bool isValidWithMaxLength(String input, int maxLength) {
  return input.length <= maxLength;
}
