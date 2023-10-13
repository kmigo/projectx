part of 'ds.dart';



class UolletiDialogs {

  static Future<T?> dialogGenericState<T>(bool success ,{BuildContext? context, Color? backgorund , BorderRadiusGeometry? borderRadius ,EdgeInsetsGeometry? padding, VoidCallback? onTap,String? message,String? title, })async{
      final ctx = context ?? navigatorKey.currentContext!;
      return await showDialog<T>(
        context: ctx,
        builder: (context) =>  _DialogAlert(_GenericState(
          success,
          message: message,
          title: title,
          onTap: onTap,
        ),backgorund ?? colorsDS.backgroundPure,padding ?? const EdgeInsets.all(15), borderRadius ?? BorderRadius.circular(5)),
      );
   }

  static Future<T?> dialogShowGeneric<T>(Widget child,{bool barrierDismissible = true,BuildContext? context,Color? backgorund ,BorderRadiusGeometry? borderRadius ,EdgeInsetsGeometry? padding}) async {
      final ctx = context ?? navigatorKey.currentContext!;
      return await showDialog<T>(
        barrierDismissible: barrierDismissible,
        context: ctx,
        builder: (context) =>  _DialogAlert(child, backgorund ?? colorsDS.backgroundPure,padding ?? const EdgeInsets.all(15), borderRadius ?? BorderRadius.circular(5) ),
      );
  }




}





class _DialogAlert extends StatelessWidget {
  final Widget child;
  final Color background;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  const _DialogAlert(this.child,this.background,this.padding,this.borderRadius);
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: padding ,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            borderRadius: borderRadius,
            color: background,
            child: child,
          ),
        ],
      ),
    );
  }
}



class _GenericState extends StatelessWidget {
  final bool success;
  final String? message;
  final String? title;
  final VoidCallback? onTap;
  const _GenericState(this.success,{Key? key, this.message,this.title,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: colorsDS.backgroundPure,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Icon(success? Icons.check_circle_outline : Icons.warning_outlined,size: 50,color: success ? colorsDS.iconsPositive : colorsDS.iconsWarning,),
          const SizedBox(
            height: 15,
          ),
           UolletiText.labelXLarge( success ?  title ?? 'Sucesso!!!' : title?? 'Ops, algo deu errado!',bold: true,),
          const SizedBox(
            height: 15,
          ),
           UolletiText.contentLarge(success ? message ?? 'Ação realizado com sucesso!' : message ?? 'Nosso time já está cuidando disso. \ntente novamente mais tarde.',color: colorsDS.textOutlined,),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: UolletiButton.primary(label: 'OK',onPressed: (){
              onTap?.call();
            },))
        ]),
      ),
    );
  }
}