import '../text_validation_rule.dart';

class IsBetween extends TextValidationRule {
  IsBetween({
    required this.max,
    required this.min,
    this.message,
  }) : super(message);

  final String? message;
  final int max;
  final int min;
  @override
  bool isValid(String input) => isBetween(input, min, max);

  @override
  String? get errorMessage =>
      message ?? 'اسم المستخدم يتراوح من $min إلى $max حرفًا';
}

bool isBetween(String input, int min, int max) {
  if (max < min) {
    throw Exception('max must be greater than min');
  }
  return input.length >= min && input.length <= max;
}
