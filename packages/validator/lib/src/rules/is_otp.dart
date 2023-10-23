import '../text_validation_rule.dart';

class IsOTP extends TextValidationRule {
  IsOTP({this.message}) : super(message);

  final String? message;
  @override
  bool isValid(String input) => isValidOTP(input);

  @override
  String? get errorMessage => message ?? 'ادخل الرمز بشكل صحيح';
}

bool isValidOTP(String input) {
  return input.length == 4;
}
