import '../text_validation_rule.dart';

class IsRequired extends TextValidationRule {
  IsRequired({this.message}) : super(message);

  final String? message;

  @override
  bool isValid(String input) => isNotEmpty(input);

  @override
  String? get errorMessage => message ?? 'هذا الحقل مطلوب';
}

bool isNotEmpty(String? string) {
  return string!.trim().isNotEmpty || string != '';
}


