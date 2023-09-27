part of 'ds.dart';

class UolletiFadePageRoute<T> extends MaterialPageRoute<T> {
  UolletiFadePageRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Verifica se a página atual é a inicial, se for, não faz a transição
    if (settings.name == AppRoutes.root) {
      return child;
    }

    // Se não for, faz a transição com FadeTransition
    return FadeTransition(opacity: animation, child: child);
  }
}
