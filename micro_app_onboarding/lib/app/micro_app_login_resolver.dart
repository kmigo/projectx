


import 'package:micro_core/micro_core.dart';

import 'pages/confirm_phone_to_create_account/confirm_phone_to_create_account.dart';

class MicroAppOnboardingResolver implements MicroApp {
  @override
  String get microAppName => 'micro_app_onboarding';
  
  @override
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.onboarding.createAccount : (ctx,args) => const ConfirmPhoneToCreatedAccount()
  };
  
  @override
  void Function() get injectionRegister => (){

  };



}