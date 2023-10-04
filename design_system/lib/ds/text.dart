part of 'ds.dart';

enum UolletiTextPriority { textLight, normal,warning}

class UolletiText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final UolletiTextPriority priority;
  final double? size;
  final Color? color;
  final TextAlign? textAlign;
  final double? height;
  const UolletiText(this.text,{super.key,this.fontWeight,this.size, this.color,this.priority = UolletiTextPriority.normal, this.textAlign, this.height});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(

        fontWeight: fontWeight,
        color: color ?? _colorText(priority),
        fontSize: size,
      ));
  }

  _colorText(UolletiTextPriority priority){

    switch (priority) {
      case UolletiTextPriority.textLight:
        return colorsDS.textLight;
      case UolletiTextPriority.normal:
        return Colors.black;
      case UolletiTextPriority.warning:
        return colorsDS.textWarning;
      default:
        return Colors.black;
    }
  }

  const UolletiText.h1(this.text,{super.key, this.color,this.fontWeight,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = 18;
  const UolletiText.h2(this.text,{super.key,this.color,this.fontWeight,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = 16;
  const UolletiText.h3(this.text,{super.key,this.color,this.fontWeight,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = 14;
  const UolletiText.h4(this.text,{super.key,this.color,this.fontWeight,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = 12;
  const UolletiText.h5(this.text,{super.key,this.color,this.fontWeight,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = 10;
  const UolletiText.labelSmall(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = 12,fontWeight = (bold == true? FontWeight.w500 : FontWeight.w300); 
  const UolletiText.labelMedium(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = (bold == true? 14 : 12),fontWeight = (bold == true? FontWeight.w500 : FontWeight.w300); 
  const UolletiText.labelLarge(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = (bold == true? 16 : 16),fontWeight = (bold == true? FontWeight.w600 : FontWeight.w300); 
  const UolletiText.labelXLarge(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = 18 ,fontWeight = (bold == true? FontWeight.w500 : FontWeight.w300); 
  const UolletiText.contentSmall(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = 12, fontWeight = (bold == true? FontWeight.w400 : FontWeight.w300);
  const UolletiText.contentMedium(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = bold ==true? 14:16, fontWeight = (bold == true? FontWeight.w400 : FontWeight.w300);
  const UolletiText.contentLarge(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = bold ==true? 16:12, fontWeight = (bold == true? FontWeight.w400 : FontWeight.w300);
  const UolletiText.captionMedium(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = (bold == true? 10 : 12),fontWeight = (bold == true? FontWeight.w600 : FontWeight.w300);
  const UolletiText.captionLarge(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = 12,fontWeight = FontWeight.w300;
  const UolletiText.captionXLarge(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign, this.height}):size = 12,fontWeight = bold == true? FontWeight.w600 : FontWeight.w300;
  const UolletiText.displaySmall(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign}):size = bold == true ? 28: 12,fontWeight = (bold == true? FontWeight.w700 : FontWeight.w300),height = 16.0;
  const UolletiText.headingLarge(this.text,{super.key,this.color,bool? bold,this.priority = UolletiTextPriority.normal,this.textAlign}):size = bold == true ? 24: 12,fontWeight = (bold == true? FontWeight.w600 : FontWeight.w300),height = bold  == true ? 24.0 : 16.0;
}