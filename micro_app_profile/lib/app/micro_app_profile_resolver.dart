import 'package:micro_app_profile/app/pages/profile_page.dart';
import 'package:micro_core/micro_core.dart';

import 'blocs/address_page/bloc.dart';
import 'blocs/get_kyc/bloc.dart';
import 'blocs/password/bloc.dart';
import 'blocs/phone_number/bloc.dart';
import 'blocs/update_kyc/bloc.dart';

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
  };

}