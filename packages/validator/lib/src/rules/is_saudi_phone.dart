import '../text_validation_rule.dart';

class IsSaudiPhone extends TextValidationRule {
  IsSaudiPhone({this.message}) : super(message);

  final String? message;
  @override
  bool isValid(String input) => isValidPhoneSaudiNumber(input);

  @override
  String? get errorMessage => message ?? 'ادخل الرقم بشكل صحيح';
}

bool isValidPhoneSaudiNumber(String string) {
  final phoneRegExp = RegExp(r'((05)([0-9]{8}))$');
  // final phoneRegExp = RegExp(r'(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})');
  return phoneRegExp.hasMatch(string);
}
