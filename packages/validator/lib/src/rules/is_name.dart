import '../text_validation_rule.dart';

class IsFullName extends TextValidationRule {
  IsFullName({this.message}) : super(message);

  final String? message;
  @override
  bool isValid(String input) => isName(input);

  @override
  String? get errorMessage => message ?? 'Enter valid Name';
}

bool isName(String? string) {
  if (string!.isEmpty) {
    return true;
  }
  return string.length > 4;
}
