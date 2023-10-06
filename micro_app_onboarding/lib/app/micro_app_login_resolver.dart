



import 'package:micro_app_onboarding/app/pages/login_page/login_page.dart';
import 'package:micro_app_onboarding/app/pages/register_phone/register_phone_page.dart';
import 'package:micro_core/micro_core.dart';

import 'pages/create_pincode_user/create_picode_user_page.dart';
import 'pages/validate_pincode/validate_picode.dart';





class MicroAppOnboardingResolver implements MicroApp {
  @override
  String get microAppName => AppRoutes.onboarding.microAppName;
  
  @override
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.onboarding.createAccount : (ctx,args) => const RegisterPhone(),
    AppRoutes.onboarding.createPin : (ctx,args) => const CreatePincodeUserPage(),
    AppRoutes.onboarding.validatePin : (ctx,args) => const ValidatePincodeUserPage(),
    AppRoutes.onboarding.login :(context, args) => const LoginPage()

  };
  
  @override
  void Function() get injectionRegister => (){


  };



}