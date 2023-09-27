part of 'ds.dart';

class UolletiNameColors {
  static const textLight = 'textLight';
  static const textOutlined = 'textOutlined';
  static const textWarning = 'textWarning';
  static const iconsOutlined = 'iconsOutlined';
  static const iconsWarning = 'iconsWarning';
  static const iconsLight = 'iconsLight';
  static const iconsDanger = 'iconsDanger';
  static const iconsMedium = 'iconsMedium'; 
  static const iconsDisabled = 'iconsDisabled';
  static const iconsPure = 'iconsPure';
  static const primary500 = 'primary500';
  static const primary900 = 'primary900';
  static const primary700 = 'primary700';
  static const backgroundPure = 'backgroundPure';
  static const backgroundLight = 'backgroundLight';
  static const backgroundMedium = 'backgroundMedium';
  static const backgroundNegative = 'backgroundNegative';
  static const primary300 = 'primary300';
  static const primary100 = 'primary100';
  static const bordersMedium = 'bordersMedium';
  static const bordersDark = 'bordersDark';
  static const buttonPositive = 'buttonPositive';
  static const buttonDisabled = 'buttonDisabled';
  static const textPositive = 'textPositive';
  static const textDanger = 'textDanger';
  static const textBlack = 'textBlack'; 
  static const textDark = 'textDark';
  static const textPure = 'textPure';
  static const textDisabled = 'textDisabled';
  static const textPrimary = 'textPrimary';
  
}

class UolletiColors {
  final Color textLight;
  final Color textOutlined;
  final Color textWarning;
  final Color iconsOutlined;
  final Color iconsWarning;
  final Color iconsLight;
  final Color iconsDanger;
  final Color iconsMedium; 
  final Color iconsDisabled;
  final Color iconsPositive;
  final Color iconsPure;
  final Color primary500;
  final Color primary900;
  final Color primary700;
  final Color backgroundPure;
  final Color backgroundLight;
  final Color backgroundMedium;
  final Color backgroundPositive;
  final Color backgroundNegative;
  final Color primary300;
  final Color primary100; 
  final Color bordersMedium;
  final Color bordersDark;
  final Color buttonPositive;
  final Color buttonDisabled;
  final Color buttonsDanger;
  final Color textPositive;
  final Color textDanger;
  final Color textBlack;
  final Color textDark;
  final Color textPure;
  final Color textDisabled;
  final Color textPrimary;
  UolletiColors(
      {
      required this.primary100,
      required this.primary300,
      required this.primary900,
      required this.primary700,
      required this.primary500, 
      required this.textPositive, 
      required this.textLight,
      required this.textPure,
      required this.textDanger,
      required this.textWarning,
      required this.bordersMedium,
      required this.bordersDark,
      required this.iconsOutlined,
      required this.iconsWarning,
      required this.iconsPositive,
      required this.iconsLight,
      required this.iconsDanger,
      required this.backgroundPure,
      required this.backgroundNegative,
      required this.backgroundPositive,
      required this.backgroundMedium,
      required this.iconsDisabled,
      required this.backgroundLight,
      required this.iconsMedium,
      required this.iconsPure,
      required this.buttonPositive,
      required this.buttonDisabled,
      required this.buttonsDanger,
      required this.textBlack,
      required this.textOutlined,
      required this.textDisabled,
      required this.textDark,
      required this.textPrimary
      });

  factory UolletiColors.fromFlavor({String? flavor}) {
    switch (flavor) {
      case 'default':
        return const UolletiColors.fallback();
      default:
        return const UolletiColors.fallback();
    }
  }

  const UolletiColors.fallback()
      : primary300 = const Color(0xFFEAECF2),
        bordersMedium = const Color(0xFFEEEEEE),
        bordersDark = const Color(0xFFCBCBCB),
        primary100 = const Color(0xFF3B4663),
        primary700 = const Color(0xFF3B4663),
        primary900 = const Color(0xFF252C3E),
        backgroundLight = const Color(0xFFEAECF2),
        backgroundPositive = const Color(0xFFC4FFCB),
        primary500 = const Color(0xFF455274),
        textLight = const Color(0xFF888888),
        textWarning = const Color(0xFFBA1A1A),
        textPure = const Color(0xFFFFFFFF),
        textPositive = const Color(0xFF03602D),
        iconsOutlined = const Color(0xFF6B6B6B),
        iconsWarning = const Color(0xFFFFA900),
        iconsDanger = const Color(0xFFBA1A1A),
        iconsDisabled = const Color(0xFFAFAFAF),
        iconsPure = const Color(0xFFFFFFFF),
        iconsMedium = const Color(0xFF888888),
        iconsLight = const Color(0xFF455274),
        iconsPositive = const Color(0xFF4DA262),
        backgroundPure = const Color(0xFFFFFFFF),
        backgroundNegative = const Color(0xFFFFDAD6),
        backgroundMedium = const Color(0xFF455274),
        buttonPositive = const Color(0xFF2E854A),
        buttonDisabled = const Color(0xFFEEEEEE),
        buttonsDanger = const Color(0xFFDB3630),
        textOutlined = const Color(0xFF6B6B6B),
        textBlack = const Color(0xFF222222),
        textDisabled = const Color(0xFFAFAFAF),
        textPrimary = const Color(0xFF3B4663),
        textDark = const Color(0xFF252C3E),
        textDanger = const Color(0xFFBA1A1A)
        ;
}

final colorsDS = UolletiColors.fromFlavor(flavor: 'default');
