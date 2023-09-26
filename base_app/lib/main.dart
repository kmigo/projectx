import 'package:flutter/material.dart';
import 'package:micro_app_onboarding/app/micro_app_login_resolver.dart';
import 'package:micro_core/micro_core.dart';

void main() {
  runApp( const MyApp());
}
class MyApp extends StatefulWidget  {
   const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with BaseApp {
  @override
  void initState() {
    super.initState();
   registerRoutes();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: "/",
    );
  }
  
  @override

  Map<String, WidgetBuildArgs> get baseRoutes => {};
  
  @override
  List<MicroApp> get microApps => [
    MicroAppOnboardingResolver()
  ];
  

}