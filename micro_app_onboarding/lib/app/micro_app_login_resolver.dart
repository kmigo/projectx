

import 'package:micro_core/micro_core.dart';

class MicroAppOnboardingResolver implements MicroApp {
  @override
  String get microAppName => 'micro_app_onboarding';
  
  @override
  // TODO: implement routes
  Map<String, WidgetBuildArgs> get routes => {};
  
  @override
  void Function() get injectionRegister => throw UnimplementedError();



}