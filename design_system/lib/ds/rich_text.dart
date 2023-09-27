part of 'ds.dart';
class UolletiRichText extends StatelessWidget {
  final String text;  
  final double? size;
  final Color? color;
  const UolletiRichText(this.text, {super.key, this.size,this.color}) ;
  const UolletiRichText.contentMedium(this.text, {super.key,this.color}) : size = 14;

  @override
  Widget build(BuildContext context) {
    return RichText(text: _parseHtmlString(text,size));
  }

  TextSpan _parseHtmlString(String html,double? size) {
    final List<TextSpan> spans = [];
    final RegExp exp = RegExp(r'<(\/)?(\w+)([^>]*)>', multiLine: true);
    final parts = exp.allMatches(html);

    int lastMatchEnd = 0;
    TextStyle currentStyle =  TextStyle(
      fontSize: size,
      color: color,
    );

    for (var match in parts) {
      final text = html.substring(lastMatchEnd, match.start);
      lastMatchEnd = match.end;

      spans.add(TextSpan(text: text, style: currentStyle));

      if (match.group(2) == "b") {
        currentStyle = match.group(1) != "/" ? currentStyle.copyWith(fontWeight: FontWeight.bold) : currentStyle.copyWith(fontWeight: FontWeight.normal);
      } else if (match.group(2) == "i") {
        currentStyle = match.group(1) != "/" ? currentStyle.copyWith(fontStyle: FontStyle.italic) : currentStyle.copyWith(fontStyle: FontStyle.normal);
      } else if (match.group(2) == "color") {
        final colorMatch = RegExp(r'value="(\w+)"').firstMatch(match.group(3)!);

        if (colorMatch != null) {
          final colorValue = colorMatch.group(1);
          currentStyle = match.group(1) != "/" ? currentStyle.copyWith(color: _colorFromName(colorValue!)) : currentStyle.copyWith(color: color);
        }
        if(match.group(1) == "/"){
          currentStyle = currentStyle.copyWith(color: color);
        }
      } else if (match.group(2) == "size") {
        final sizeMatch = RegExp(r'value="([\d\.]+)"').firstMatch(match.group(3)!);
        if (sizeMatch != null) {
          final sizeValue = sizeMatch.group(1);
          currentStyle = match.group(1) != "/" ? currentStyle.copyWith(fontSize: double.tryParse(sizeValue!)) : currentStyle;
        }
      }
    }

    spans.add(TextSpan(text: html.substring(lastMatchEnd), style: currentStyle));

    return TextSpan(children: spans);
  }

  Color? _colorFromName(String name) {
    switch (name) {
      case UolletiNameColors.textLight:
        return colorsDS.textLight;
      case UolletiNameColors.textOutlined:
        return colorsDS.textOutlined;
      case UolletiNameColors.textWarning:
        return colorsDS.textWarning;
      case UolletiNameColors.iconsOutlined:
        return colorsDS.iconsOutlined;
      case UolletiNameColors.iconsWarning:
        return colorsDS.iconsWarning;
      case UolletiNameColors.iconsLight:
        return colorsDS.iconsLight;
      case UolletiNameColors.iconsDanger:
        return colorsDS.iconsDanger;
      case UolletiNameColors.iconsMedium:
        return colorsDS.iconsMedium;
      case UolletiNameColors.iconsDisabled:
        return colorsDS.iconsDisabled;
      case UolletiNameColors.iconsPure:
        return colorsDS.iconsPure;
      case UolletiNameColors.primary500:
        return colorsDS.primary500;
      case UolletiNameColors.primary900:
        return colorsDS.primary900;
      case UolletiNameColors.primary700:
        return colorsDS.primary700;
      case UolletiNameColors.backgroundPure:
        return colorsDS.backgroundPure;
      case UolletiNameColors.backgroundLight:
        return colorsDS.backgroundLight;
      case UolletiNameColors.backgroundMedium:
        return colorsDS.backgroundMedium;
      case UolletiNameColors.backgroundNegative:
        return colorsDS.backgroundNegative;
      case UolletiNameColors.primary300:
        return colorsDS.primary300;
      case UolletiNameColors.primary100:
        return colorsDS.primary100;
      case UolletiNameColors.bordersMedium:
        return colorsDS.bordersMedium;
      case UolletiNameColors.bordersDark:
        return colorsDS.bordersDark;
      case UolletiNameColors.buttonPositive:  
        return colorsDS.buttonPositive;
      case UolletiNameColors.buttonDisabled:
        return colorsDS.buttonDisabled;
      case UolletiNameColors.textPositive:
        return colorsDS.textPositive;
      case UolletiNameColors.textDanger:
        return colorsDS.textDanger;
      case UolletiNameColors.textBlack:
        return colorsDS.textBlack;
      case UolletiNameColors.textDark:  
        return colorsDS.textDark;
      case UolletiNameColors.textPure:
        return colorsDS.textPure;
      case UolletiNameColors.textDisabled:
        return colorsDS.textDisabled;
      case UolletiNameColors.textPrimary:
        return colorsDS.textPrimary;
      default:
        return colorsDS.textLight;
    }
  }
}