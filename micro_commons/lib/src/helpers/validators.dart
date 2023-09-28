part of 'helpers.dart';
class HelperValidator {
  static bool email(String? text) {
    if (text == null) return false;
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(text);
  }

  static bool phone(String? text) {
    if (text == null) return false;
    text = text.replaceAll(RegExp(r'\D'), '');
    if (text.length == 11) return true;
    return false;
  }

  static bool password(String? text) {
    if (text == null) return false;
    if (text.length < 6) return false;
    return true;
  }
  static bool cep(String? text) {
    text = text?.replaceAll(RegExp(r'\D'), '');
    if (text == null) return false;
    if (text.length < 8) return false;
    return true;
  }
  static bool isCPF(String? input) {
    if (input == null) return false;
  if (input.length != 11) return false;

  final digits = input.replaceAll(RegExp(r'\D'), '').split('').map((d) => int.parse(d)).toList();
  if(digits.length != 11) return false;
  int calculateDigit(List<int> digits, int start, int end) {
    int weight = end + 1;
    int sum = 0;
    for (int i = start; i < end; i++, weight--) {
      sum += weight * digits[i];
    }
    return (sum % 11 < 2) ? 0 : 11 - (sum % 11);
  }

  if (digits[9] != calculateDigit(digits, 0, 9)) return false;
  if (digits[10] != calculateDigit(digits, 0, 10)) return false;

  return true;
}
static bool isBirthDate(String? input) {
  final RegExp regex = RegExp(r'^(0[1-9]|1[0-9]|2[0-8]|(29(?=\/02\/(?:(\d{2}(?:[02468][048]|[13579][26]))|(?:[02468][048]00|[13579][26]00))))|30(?=\/(0[13-9]|1[0-2])\/)|31(?=\/(0[13578]|1[02])\/))/(\d{4})$');

  if ( input == null|| !regex.hasMatch(input)) {
    return false;
  }
  return true;
}

  static bool required(String? text) {
    return text?.isNotEmpty == true;
  }
  static bool isCNPJ(String? input) {
    if (input == null) return false;
  if (input.length != 14) return false;

final digits = input.replaceAll(RegExp(r'\D'), '').split('').map((d) => int.parse(d)).toList();
  if(digits.length != 14) return false;

  int calculateDigit(List<int> digits, int start, int end, List<int> weights) {
    int sum = 0;
    for (int i = start, j = 0; i < end; i++, j++) {
      sum += weights[j] * digits[i];
    }
    return (sum % 11 < 2) ? 0 : 11 - (sum % 11);
  }

  var weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  var weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  if (digits[12] != calculateDigit(digits, 0, 12, weights1)) return false;
  if (digits[13] != calculateDigit(digits, 0, 13, weights2)) return false;

  return true;
}

  static bool isValidBrazilianPhoneNumber(String input) {
    /*
    Esta expressão regular validará as seguintes formas de números de telefone:

+5511987654321
+55 11987654321
+55 (11)987654321
+55 (11) 987654321
+55 11 9876-5432
11987654321
11 987654321
(11)987654321
(11) 987654321
11 9876-5432
     */
    RegExp regex = RegExp(
      r'^(\+55)?\s?\(?\d{2}\)?[\s-]?\d{4,5}[-\s]?\d{4}$',
    );

    return regex.hasMatch(input);
  }
}

class HelperInputValidator {
  static String? required(String? text){
    if(HelperValidator.required(text)) return null;
    return 'Campo obrigatório';
  }
  static String? cpf(String? text){
    if(HelperValidator.isCPF(text)) return null;
    return 'CPF inválido';
  }
  static String? birthdate(String? text){
    if(HelperValidator.isBirthDate(text)) return null;
    return 'Data de nascimento inválida';
  }

  static String? email(String? text){
    if(HelperValidator.email(text)) return null;
    return 'E-mail inválido';
  }
  static String? cep(String? text){
    if(HelperValidator.cep(text)) return null;
    return 'Cep inválido';
  }
}

class HelperValidatorMask {
  static bool validateMaskToNumbers(String? text, String? mask) {
    if (text == null) return false;
    if (mask == null) return false;

    final regex= _convertMaskToRegex(mask);

    return RegExp(regex).hasMatch(text);
  }

  static String _convertMaskToRegex(String mask) {
    return mask
        .replaceAllMapped(RegExp(r'#'), (match) => r'\d')
        .replaceAllMapped(RegExp(r'\('), (match) => r'\(')
        .replaceAllMapped(RegExp(r'\)'), (match) => r'\)')
        .replaceAllMapped(RegExp(r' '), (match) => r' ')
        .replaceAllMapped(RegExp(r'-'), (match) => r'-');
  }
}