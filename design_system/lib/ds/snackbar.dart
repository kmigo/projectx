

part of 'ds.dart';

class UolletiSnackbar extends StatelessWidget {
  final Color backgroundColor;
  final Widget?  title;
  final Widget? trailling;
  final Widget? leading;
  final double? top;
  final double? left;
  final double? bottom;
  final double? rigth;
  final EdgeInsetsGeometry? padding;
  const UolletiSnackbar({super.key,required this.backgroundColor ,this.padding ,this.left , this.top , this.bottom, this.rigth , required this.title,required this.trailling,required this.leading}) ;
  const UolletiSnackbar.bottom({super.key,required this.backgroundColor ,this.padding , required this.title,required this.trailling,required this.leading}) : top = null, left = null, rigth = null, bottom = 0;
   UolletiSnackbar.bottomError({super.key ,this.padding ,required String message}) : top = null, left = null, rigth = null, bottom = 0,backgroundColor=colorsDS.iconsDanger, title = UolletiText.contentLarge(message,color: colorsDS.textPure, bold: true),trailling= const SizedBox(),leading= const SizedBox();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: rigth,
      child: Container(
        width: width,
        padding: padding,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              if(leading != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: leading,
                ),
              Expanded(

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: title,
                ),
              ),
              if(trailling != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: trailling,
                ),
            ],
          ),
        ),
      ),
    );
  }
}


void showUolletiSnackbar(BuildContext context, UolletiSnackbar child,Duration duration) {
  final overlay = Overlay.of(context);

  final overlayEntry = OverlayEntry(
    builder: (context) => child,
  );

  overlay.insert(overlayEntry);

  // Feche o SnackBar depois de um determinado período
  Future.delayed(duration, () {
    overlayEntry.remove();
  });
}