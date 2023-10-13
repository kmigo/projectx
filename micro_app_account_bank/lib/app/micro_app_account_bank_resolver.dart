import 'package:micro_app_account_bank/app/blocs/register_account_bank_origin/bloc.dart';
import 'package:micro_app_account_bank/app/pages/register_account_bank_origin/register_account_bank_origin_page.dart';
import 'package:micro_app_account_bank/app/pages/list_account_bank/list_account_bank_page.dart';
import 'package:micro_app_account_bank/src/usecases/get_all_accounts_bank.dart';
import 'package:micro_core/micro_core.dart';

import '../src/datasource/account_datasource.dart';
import '../src/repositories/account_repository.dart';
import '../src/usecases/create_account_bank.dart';
import '../src/usecases/create_card.dart';
import 'blocs/list_accounts_bank/bloc.dart';

import 'blocs/new_card/bloc.dart';
import 'blocs/register_account_bank_receiver/bloc.dart';
import 'pages/new_card/new_card_page.dart';
import 'pages/register_account_bank_receiver/register_account_bank_receiver_page.dart';
import 'pages/new_recharge/new_recharge_page.dart';

class MicroAppAccountBankResolver extends MicroApp {
  @override
  void Function() get injectionRegister => (){
    // DATASOURCE
    CoreBinding.registerLazySingleton<AccountDatasource>((i) => AccountDatasourceImpl(i()));
    // REPOSITORY
    CoreBinding.registerLazySingleton<RepositoryAccount>((i) => RepositoryAccountImpl(i()));
    // USECASE
    CoreBinding.registerLazySingleton<CreateBankAccountUsecase>((i) => CreateBankAccountUsecaseImpl(i()));
    CoreBinding.registerLazySingleton<GetAllAccountsBankUsecase>((i) => GetAllAccountsBankUsecaseImpl(i()));
    CoreBinding.registerLazySingleton<CreateCardUsecase>((i) => CreateCardUsecaseImpl(i()));
    // BLOC
    CoreBinding.registerFactory((i) => RegisterAccountBankOriginBloc(i()));
    CoreBinding.registerLazySingleton((i) => ListAccountsBankBloc(i()));
    CoreBinding.registerFactory((i) => RegisterAccountBankReceiverBloc(i()));
    CoreBinding.registerFactory((i) => NewCardBloc(i()));

  };

  @override
  String get microAppName =>AppRoutes.accountBank.microAppName;

  @override
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.accountBank.registerBankOrigin : (ctx,args) => const RegisterAccountBankOriginPage(),
    AppRoutes.accountBank.newRecharge : (ctx,args) => const NewRechargePage(),
    AppRoutes.accountBank.accounts:(context, args) => const ListAccountBankPage(),
    AppRoutes.accountBank.registerBankReceiver:(context, args) => const RegisterAccountBankReceiverPage(),
    AppRoutes.accountBank.newCardAccountBank:(context,args) => const NewCardPage(),
  };

}