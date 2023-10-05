import 'package:micro_app_account_bank/app/pages/register_account_bank/register_account_bank_page.dart';
import 'package:micro_core/micro_core.dart';

import '../src/datasource/account_datasource.dart';
import '../src/repositories/account_repository.dart';
import '../src/usecases/create_account_bank.dart';
import 'blocs/register_account_bank/bloc.dart';

class MicroAppAccountBankResolver extends MicroApp {
  @override
  void Function() get injectionRegister => (){
    // DATASOURCE
    CoreBinding.registerLazySingleton<AccountDatasource>((i) => AccountDatasourceImpl(i()));
    // REPOSITORY
    CoreBinding.registerLazySingleton<RepositoryAccount>((i) => RepositoryAccountImpl(i()));
    // USECASE
    CoreBinding.registerLazySingleton<CreateBankAccountUsecase>((i) => CreateBankAccountUsecaseImpl(i()));
    // BLOC
    CoreBinding.registerFactory((i) => RegisterAccountBankBloc(i()));

  };

  @override
  String get microAppName =>AppRoutes.accountBank.microAppName;

  @override
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.accountBank.registerBank : (ctx,args) => const RegisterAccountBankPage(),
  };

}