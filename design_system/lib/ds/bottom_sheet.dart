part of 'ds.dart';

class UolletiBottomSheet {
    static show(Widget child, {BuildContext? context}){
      final ctx = context ?? navigatorKey.currentState!.context;
      showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        ),
        builder: (context) => child
      );
    }
}