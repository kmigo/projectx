part of 'ds.dart';



class UolletiButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? backgroundDisabled;
  final bool disabled;
  final Color? textColor;
  final Color? textColorDisabled;
  final bool isLoading;
  const UolletiButton({super.key,required this.label, required this.textColorDisabled,required this.backgroundDisabled,this.disabled =false,this.onPressed, this.isLoading = false,this.backgroundColor, this.textColor });
  UolletiButton.primary({super.key,required this.label,this.disabled = false,this.onPressed, this.isLoading = false}): backgroundColor = colorsDS.primary900, textColor = colorsDS.textPure, backgroundDisabled = colorsDS.buttonDisabled, textColorDisabled = colorsDS.textDisabled;
  UolletiButton.positive({super.key,required this.label ,this.disabled =true ,this.onPressed,this.isLoading = false}): backgroundColor = colorsDS.buttonPositive, textColor = colorsDS.textPure, backgroundDisabled = colorsDS.buttonDisabled,textColorDisabled = colorsDS.textDisabled;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 48,
      width: double.infinity,
      child: GestureDetector(

        onTap: isLoading || disabled ? null : onPressed!= null ? (){
          CoreBinding.get<UolletiKeyboardBloc>().hide();
          onPressed?.call();
        }: null,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: disabled ? backgroundDisabled : backgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const[
               BoxShadow(
                color: Colors.black12,
                offset:  Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: isLoading ?  const Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),),
          ) : UolletiText.labelLarge(label,color: disabled ? textColorDisabled : textColor,),
        ),
      ),
      // child: ElevatedButton(onPressed: onPressed!= null ? (){
      //   CoreBinding.get<UolletiKeyboardBloc>().hide();
      //   onPressed?.call();
      // }: null,
      // style: ElevatedButton.styleFrom(
      //   backgroundColor: backgroundColor
      // ), child: UolletiText.labelLarge(label,color: textColor,),
      // ),
    );
  }
}

enum UolletiButtonPriority { primary,danger}

enum UolletiButtonSize { contain,infinity }

class UolletiButtonText extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  const UolletiButtonText({super.key, required this.label, this.onPressed, required this.color});
  UolletiButtonText.textLigth({super.key, required this.label, this.onPressed}): color = colorsDS.textLight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed!= null ? (){
        CoreBinding.get<UolletiKeyboardBloc>().hide();
        onPressed?.call();
      }: null,
      child: Container(
        alignment: Alignment.center,
        height: 48,
        width: double.infinity,
        child: UolletiText.labelLarge(label,color: color,),
      ),
    );
  }

}
class UolletiButtonIcon extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback? onPressed;
  final UolletiButtonPriority priority;
  final bool isLoading;
  final UolletiButtonSize size;
  final bool preFixIcon;
  final bool? disabled;
  const UolletiButtonIcon({super.key,required this.icon, this.preFixIcon =true, this.disabled,required this.label,this.onPressed,this.priority = UolletiButtonPriority.primary,this.size = UolletiButtonSize.infinity, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
      final iconTheme = Padding(
        padding: const EdgeInsets.only(right:8.0),
        child: IconTheme(
                  data: IconThemeData(
                    color: onPressed ==  null? colorsDS.iconsDisabled : colorsDS.iconsPure
                  ),
                  child: icon),
      );
      return GestureDetector(
        onTap: onPressed == null || isLoading || disabled == true ? null:   (){
        CoreBinding.get<UolletiKeyboardBloc>().hide();
        onPressed?.call();
      },
        child: Container(
          height: 48,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: onPressed == null || isLoading || disabled == true ? colorsDS.buttonDisabled : _color(priority),
            borderRadius: BorderRadius.circular(8),
            // shadow elevation
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: isLoading ? const Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),),
        ): Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(preFixIcon)iconTheme,
              UolletiText.labelLarge(label,color: onPressed == null ? colorsDS.textDisabled : colorsDS.textPure,),
              const SizedBox(width: 10,),
              if(!preFixIcon)iconTheme,
            ],
          ),
        ),
      );
    
  
  }

  Color _color(UolletiButtonPriority priority){
    switch (priority) {
      case UolletiButtonPriority.primary:
        return colorsDS.primary900;
      case UolletiButtonPriority.danger:
        return colorsDS.buttonsDanger;
      default:
        return colorsDS.primary900;
    }
  }
}


class UolletiExtraLargeIconButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final VoidCallback? onPressed;
  const UolletiExtraLargeIconButton({super.key,required this.icon, required this.label,required this.backgroundColor,required this.borderColor,required this.iconColor, this.onPressed});
    UolletiExtraLargeIconButton.fill({super.key,required this.icon, required this.label,this.onPressed}):iconColor =colorsDS.textPure,borderColor = Colors.transparent,backgroundColor = colorsDS.buttonPositive;
     UolletiExtraLargeIconButton.outlined({super.key,required this.icon, required this.label,this.onPressed}):iconColor =colorsDS.iconsLight,borderColor = colorsDS.bordersDark,backgroundColor = colorsDS.backgroundPure;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed!= null ? (){
        CoreBinding.get<UolletiKeyboardBloc>().hide();
        onPressed?.call();
      }: null,
      child: Container(
        width: 158,
        padding: const EdgeInsets.only(right: 10,top: 35,left: 15,bottom: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 10,),
            UolletiText.labelLarge(label,color: iconColor,)
          ],
        ),
      ),
    );
  }
}