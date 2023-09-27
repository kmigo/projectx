part of 'helpers.dart';
class HelperMask {
  static cpf(String? value) {
    if(value == null) return '';
     String numericOnly = value.replaceAll(RegExp(r'\D'), '');
     return numericOnly.replaceAllMapped(
      RegExp(r'(\d{3})(\d{3})(\d{3})(\d{2})'),
      (Match m) => '${m[1]}.${m[2]}.${m[3]}-${m[4]}',
    );
  }
  static cnpj(String value) {
    String numericOnly = value.replaceAll(RegExp(r'\D'), '');
    return numericOnly.replaceAllMapped(
      RegExp(r'(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})'),
      (Match m) => '${m[1]}.${m[2]}.${m[3]}/${m[4]}-${m[5]}',
    );
  }
  static phone(String value) {
    String numericOnly = value.replaceAll(RegExp(r'\D'), '');
    return numericOnly.replaceAllMapped(
      RegExp(r'(\d{2})(\d{5})(\d{4})'),
      (Match m) => '(${m[1]}) ${m[2]}-${m[3]}',
    );
  }
  static dynamicCpfCpnpjPhone(String value) {
    if (HelperValidator.isCPF(value)) {
      return cpf(value);
    } else if (HelperValidator.isCNPJ(value)) {
      return cnpj(value);
    } else if (HelperValidator.isValidBrazilianPhoneNumber(value)) {
      return phone(value);
    } else {
      return value;
    }
  }
}



class CpfInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (newText.length > 11) {
      // Se o novo comprimento do texto for maior que 11 (máximo para um CPF), retorne o valor antigo.
      return oldValue;
    }

    for(int i = 0; i < newText.length; i++) {
      if ([3, 7].contains(i)) {
        newText = newText.replaceRange(i, i, '.');
      } else if (i == 11) {
        newText = newText.replaceRange(i, i, '-');
      }
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
  }

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    for (int i = 0; i < newText.length; i++) {
      if (i == 2 || i == 5) {
        newText = newText.replaceRange(i, i, '/');
      }
    }
    if(newText.length > 10) {
      return oldValue;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class CepInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    if (newText.length <= 5) {
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    if(newText.length > 8) {
      return oldValue;
    }
    return TextEditingValue(
      text: '${newText.substring(0, 5)}-${newText.substring(5, newText.length)}',
      selection: TextSelection.collapsed(offset: newValue.text.length + 1),
    );
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();
    String newString = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    int selectionIndex = newString.length;
    if (newString.length > 11) {
      return oldValue;
    }
    for (int i = 0; i < newString.length; i++) {
      if (i == 0) {
        newText.write('(');
        if (selectionIndex > 0) selectionIndex++;
      } else if (i == 2) {
        newText.write(') ');
        if (selectionIndex > 2) selectionIndex += 2;
      } else if (i == 7) {
        newText.write('-');
        if (selectionIndex > 7) selectionIndex++;
      }
      newText.write(newString[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class MaskHintText{
  static const cpf = '000.000.000-00';
  static String maskPhoneCountry(String country) {
    switch (country) {
      case '+55':
        return '(00) 00000-0000';
      case '+1':
        return '(000) 000-0000';
      case '+351':
        return '000 000 000';
      case '+595':
        return '0000 000 000';
      case '+44':
        return '0000 000000';
      case '+81':
        return '000-0000-0000';
      default:
        return '';
    }
  }
}