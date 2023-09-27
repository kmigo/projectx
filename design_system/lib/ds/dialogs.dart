part of 'ds.dart';



class UolletiDialogs {

  static dialogGenericState(bool success ,{BuildContext? context, VoidCallback? onTap,String? message,String? title, }){
      final ctx = context ?? navigatorKey.currentContext!;
      showDialog(
        context: ctx,
        builder: (context) =>  _DialogAlert(_GenericState(
          success,
          message: message,
          title: title,
          onTap: onTap,
        )),
      );
   }

  static dialogShowGeneric(Widget child,{BuildContext? context}){
      final ctx = context ?? navigatorKey.currentContext!;
      showDialog(
        context: ctx,
        builder: (context) =>  _DialogAlert(child),
      );
  }




}





class _DialogAlert extends StatelessWidget {
  final Widget child;
  const _DialogAlert(this.child);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: child,
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