import 'text_validation_rule.dart';

String? Function(String? value)? customValidator({
  required List<TextValidationRule> rules,
}) {
  return (String? input) {
    String? msg;

    for (final rule in rules) {
      msg = rule.isValid(input!) ? null : rule.errorMessage!;

      if (msg != null) {
        break;
      }
    }

    return msg;
  };
}
