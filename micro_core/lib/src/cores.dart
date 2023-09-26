import 'package:flutter/material.dart';

typedef WidgetBuildArgs = Widget Function(BuildContext context, dynamic args);

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


abstract class MicroApp {
  String get microAppName;
  Map<String,WidgetBuildArgs> get routes;

    void Function() get injectionRegister;
}

mixin BaseApp {
  List<MicroApp> get microApps;
  final Map<String,WidgetBuildArgs>  routes = {};

  Map<String,WidgetBuildArgs> get baseRoutes;

void registerInjections(){
  for (var microapp in microApps) {
    microapp.injectionRegister();
  }
}

  void registerRoutes(){
    if(baseRoutes.isNotEmpty){
      routes.addAll(baseRoutes);
    }
    if(microApps.isNotEmpty){
      for (var microapp in microApps) {
        routes.addAll(microapp.routes);
      }
    }
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final routeName = settings.name;
    if (routeName == null) {
      return null;
    }
    final navigateTo = routes[routeName];
    if(navigateTo == null){
      return null;
    }
    if (routes.containsKey(routeName)) {
      return MaterialPageRoute(
          builder: (context) => navigateTo.call(context, args));
    }
    return null;
  }

}


class CoreNavigator {
  static void pushNamed(String routeName, {dynamic args}) {
    navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  static void pushReplacementNamed(String routeName, {dynamic args}) {
    navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: args);
  }

  static void pop() {
    navigatorKey.currentState!.pop();
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static void popAndPushNamed(String routeName, {dynamic args}) {
    navigatorKey.currentState!.popAndPushNamed(routeName, arguments: args);
  }

  static void pushNamedAndRemoveUntil(String routeName, {dynamic args}) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, ModalRoute.withName(routeName),
        arguments: args);
  }

  static void push(Widget widget) {
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  static void pushReplacement(Widget widget) {
    navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  static void pushAndRemoveUntil(Widget widget) {
    navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return widget;
    }), (route) => false);
  }

  static void pushRoute(Route route) {
    navigatorKey.currentState!.push(route);
  }

  static void pushReplacementRoute(Route route) {
    navigatorKey.currentState!.pushReplacement(route);
  }

  static void pushAndRemoveUntilRoute(Route route) {
    navigatorKey.currentState!.pushAndRemoveUntil(route, (route) => false);
  }

  static void popRoute() {
    navigatorKey.currentState!.pop();
  }

  static void popUntilRoute(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static void popAndPushNamedRoute(String routeName, {dynamic args}) {
    navigatorKey.currentState!.popAndPushNamed(routeName, arguments: args);
  }

  static void pushNamedAndRemoveUntilRoute(String routeName, {dynamic args}) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, ModalRoute.withName(routeName),
        arguments: args);
  }

  static void pushRouteReplacementNamed<T extends Object?, TO extends Object?>(Route<T> newRoute, {TO? result}) {
    navigatorKey.currentState!.pushReplacement(newRoute, result: result);
    }
    
}