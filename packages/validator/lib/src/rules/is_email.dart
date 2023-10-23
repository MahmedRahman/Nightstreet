import '../text_validation_rule.dart';

const String emailRegex =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class IsEmail extends TextValidationRule {
  IsEmail({this.message}) : super(message);

  final String? message;
  @override
  bool isValid(String input) => isValidEmail(input);

  @override
  String? get errorMessage => message ?? 'ادخل البريد الالكتروني بشكل صحيح';
}

bool isValidEmail(String input) {
  if (input.isEmpty) {
    return true;
  }
  final RegExp exp = RegExp(emailRegex);
  return exp.hasMatch(input);
}
