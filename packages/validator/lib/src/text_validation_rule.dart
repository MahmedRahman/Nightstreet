abstract class TextValidationRule {
  final String? errorMessage;
  TextValidationRule(this.errorMessage);

  bool isValid(String input);
}
