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


class CurrencyInputFormatter extends TextInputFormatter {
  final String currency;

  CurrencyInputFormatter({required this.currency});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    
    // Remove caracteres não numéricos
    newText = newText.replaceAll(RegExp('[^0-9]'), '');

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    double value = double.parse(newText) / 100;

    String formattedValue;

    if (currency == 'US') {
      formattedValue = '\$ ${value.toStringAsFixed(2)}';
    } else if (currency == 'R\$') {
      formattedValue = 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
    } else {
      formattedValue = newValue.text;
    }

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
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



class MaskedInputFormatter extends TextInputFormatter {
  final String mask;

  const MaskedInputFormatter({this.mask = '(##) ####-####'});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = _applyMask(mask, newValue.text);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _applyMask(String mask, String value) {
    final numericText = value.replaceAll(RegExp(r'\D'), '');
    var maskedText = '';
    var maskCharIndex = 0;
    var numericCharIndex = 0;

    while (maskCharIndex < mask.length && numericCharIndex < numericText.length) {
      final maskChar = mask[maskCharIndex];
      final numericChar = numericText[numericCharIndex];

      if (maskChar == '#') {
        maskedText += numericChar;
        maskCharIndex++;
        numericCharIndex++;
      } else {
        maskedText += maskChar;
        maskCharIndex++;
      }
    }

    return maskedText;
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