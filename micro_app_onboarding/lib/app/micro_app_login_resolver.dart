


import 'package:micro_app_onboarding/app/bloc/login_phone/bloc.dart';
import 'package:micro_app_onboarding/app/pages/register_phone/confirm_phone_to_create_account.dart';
import 'package:micro_core/micro_core.dart';


import 'bloc/create_pincode/bloc.dart';

import 'bloc/register_phone/bloc.dart';
import 'pages/create_pincode/create_pincode_page.dart';
import 'pages/login_phone/login_phone_page.dart';

class MicroAppOnboardingResolver implements MicroApp {
  @override
  String get microAppName => AppRoutes.onboarding.microAppName;
  
  @override
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.onboarding.createAccount : (ctx,args) => const ConfirmPhoneToCreatedAccount(),
    AppRoutes.onboarding.createPin : (ctx,args) => const CreatePincodePage(),
    AppRoutes.onboarding.login : (ctx,args) => const LoginPhonePage(),

  };
  
  @override
  void Function() get injectionRegister => (){
    CoreBinding.registerFactory<ConfirmPhoneToCreateAccountBloc>((i) => ConfirmPhoneToCreateAccountBloc(i(),i()));
    CoreBinding.registerFactory<CreatePinCodeBloc>((i) => CreatePinCodeBloc(i()));
    CoreBinding.registerFactory<LoginPhoneBloc>((i) => LoginPhoneBloc(i(),i() ));
  };



}