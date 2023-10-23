import '../text_validation_rule.dart';

class IsOptional extends TextValidationRule {
  IsOptional({this.message}) : super(message);

  final String? message;

  @override
  bool isValid(String input) => true;

  @override
  String? get errorMessage => message ?? 'هذا الحقل مطلوب';
}




