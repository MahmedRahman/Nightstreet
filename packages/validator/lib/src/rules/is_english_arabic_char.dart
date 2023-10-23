import '../text_validation_rule.dart';

class IsEnglishArabicChar extends TextValidationRule {
  IsEnglishArabicChar({this.message}) : super(message);

  final String? message;
  @override
  bool isValid(String input) => isValidChar(input);

  @override
  String? get errorMessage => message ?? 'يجب ان لا يحتوي الاسم علي ارقام';
}

bool isValidChar(String string) {
  final RegExp pattern = RegExp(r'^[^\d\u0660-\u0669\u06F0-\u06F9]+$');

  return pattern.hasMatch(string);
}
