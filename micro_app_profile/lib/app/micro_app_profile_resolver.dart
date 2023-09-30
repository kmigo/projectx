

import 'package:micro_app_profile/app/pages/fingerprint/fingerprint_page.dart';
import 'package:micro_app_profile/app/pages/limit/limit_page.dart';
import 'package:micro_app_profile/app/pages/profile_page.dart';
import 'package:micro_app_profile/app/pages/selfie/selfie_page.dart';
import 'package:micro_app_profile/app/pages/validator_document/validator_document_page.dart';
import 'package:micro_core/micro_core.dart';

import 'blocs/address_page/bloc.dart';
import 'blocs/get_kyc/bloc.dart';
import 'blocs/password/bloc.dart';
import 'blocs/phone_number/bloc.dart';
import 'blocs/update_kyc/bloc.dart';
import 'pages/address/address_page.dart';
import 'pages/password/password_page.dart';
import 'pages/personal/personal_page.dart';
import 'pages/phone/phone_page.dart';

class MicroAppProfileResolver extends MicroApp {
  @override
  void Function() get injectionRegister =>(){
    CoreBinding.registerFactory<AddressBloc>((i) => AddressBloc(i()));
    CoreBinding.registerFactory<BlocUserKyc>((i) => BlocUserKyc(i()));
    CoreBinding.registerFactory<PasswordBloc>((i) => PasswordBloc(i(),i()));
    CoreBinding.registerFactory<PhoneNumberBloc>((i) => PhoneNumberBloc(i(),i()));
    CoreBinding.registerFactory<BlocUpdateKyc>((i) => BlocUpdateKyc(i(),i()));
  };

  @override
  String get microAppName => AppRoutes.profile.microAppName;

  @override
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.profile.root :(context, args) => const ProfilePage(),
    AppRoutes.profile.address :(context, args) => const AddressPage(),
    AppRoutes.profile.password :(context, args) => const ProfilePasswordPage(),
    AppRoutes.profile.personal:(context, args) => const PersonalPage(),
    AppRoutes.profile.fingerprint:(context, args) => const FingerprintPage(),
    AppRoutes.profile.limit:(context, args) => const LimitPage(),
    AppRoutes.profile.phoneNumber: (context,args) => const PersonalPhonePage(),
    AppRoutes.profile.selfie: (context,args) => const SelfiePage(),
    AppRoutes.profile.validatorDocument : (context,args) => const ValidatorDocumentPage()
  };

}