// ignore_for_file: unused_element, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';


import 'package:micro_core/micro_core.dart';

typedef WidgetBuildArgs = Widget Function(BuildContext context, dynamic args);

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


abstract class MicroApp {
  String get microAppName;
  Map<String,WidgetBuildArgs> get routes;
  void Function() get injectionRegister;
}


class CoreBinding {

B call<B extends Object>() {
  final a =  GetIt.instance.get<B>();
  return a;
  }
  static void registerSingleton<T extends Object>(T Function(CoreBinding) instance) {

    final a= instance.call(CoreBinding());

    GetIt.instance.registerSingleton<T>(a);
  }

  static void registerLazySingleton<T extends Object>(T Function(CoreBinding) instance) {
    GetIt.instance.registerLazySingleton<T>(()=>instance.call(CoreBinding()));
  }

  static void registerFactory<T extends Object>(T Function(CoreBinding) instance) {
    GetIt.instance.registerFactory<T>(()=>instance.call(CoreBinding()));
  }

  static T get<T extends Object>() {
    return GetIt.instance.get<T>();
  }
}
var _queryParams = <String,String>{};
const _binds = [];

var _args;

class CorePageModal {
  static dynamic get args {
    return _args;
  }
  static Map<String,String>  get queryParams {
    return _queryParams;
  }
}

mixin BaseApp {
  List<MicroApp> get microApps;
  final Map<String,WidgetBuildArgs>  routes = {};

  Map<String,WidgetBuildArgs> get baseRoutes;


void registerInjections(){
  CoreBinding.registerSingleton<ClientHttp>((i) => HttpClientDio(
    baseUrl:'http://localhost:65182/#/',

  ));

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
    _args = args;
    String? routeName = settings.name;
    String? oldRouteName = routeName;
    if (routeName == null) {
      return null;
    }
    if(routeName.split('?').length > 1){
      final data = routeName.split('?')[1].split('&');
  var obj = <String,String>{};
  for( var query in data){
    final querparam = query.split('=');
    obj[querparam[0]] = querparam[1];
  }
  routeName = routeName.split('?')[0];
  _queryParams = obj;
    }
    final navigateTo = routes[routeName];
    if(navigateTo == null){
      return null;
    }
    if (routes.containsKey(routeName)) {
      return MaterialPageRoute(
        settings: RouteSettings(name: oldRouteName, arguments: args),
          builder: (context) => navigateTo.call(context, args));
    }
    return null;
  }

}


class CoreNavigator {
  static Future<T?> pushNamed<T extends Object?>(String routeName, {dynamic args}) async{
   return await  navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  static  Future<T?> pushReplacementNamed<T extends Object?>(String routeName, {dynamic args}) async{
    return await navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: args);
  }

  static void pop() {
    navigatorKey.currentState!.pop();
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static Future<T?> popAndPushNamed<T extends Object?>(String routeName, {dynamic args}) async {
    return await navigatorKey.currentState!.popAndPushNamed(routeName, arguments: args);
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
  String newRouteName,
  bool Function(Route<dynamic>) predicate, {
  Object? arguments,
}) async{
    return await navigatorKey.currentState!.pushNamedAndRemoveUntil(
        newRouteName, predicate,
        arguments: arguments);
  }

  static Future<T?> push<T extends Object?>(Widget widget) async {
    return await navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) {
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