
import 'package:micro_app_transactions/src/datasource/currency.dart';
import 'package:micro_app_transactions/src/repositories/currency.dart';
import 'package:micro_app_transactions/src/usecases/get_currency.dart';
import 'package:micro_core/micro_core.dart';

import '../src/datasource/account_datasource.dart';
import '../src/datasource/card_datasource.dart';
import '../src/repositories/account_repository.dart';
import '../src/repositories/card.dart';

import '../src/usecases/get_all_accounts_bank.dart';
import '../src/usecases/get_card_by_id.dart';
import 'blocs/get_card/bloc.dart';
import 'blocs/get_currency/bloc.dart';
import 'blocs/list_accounts_bank/bloc.dart';
import 'pages/review_new_recharge/review_new_recharge_page.dart';


class MicroAppTransactionsResolver extends MicroApp {
  @override
  void Function() get injectionRegister => (){
    // DATASOURCE
    CoreBinding.registerLazySingleton<AccountDatasource>((i) => AccountDatasourceImpl(i()));
    CoreBinding.registerLazySingleton<CardDatasource>((i) => CardDatasourceImpl(i()));
    CoreBinding.registerLazySingleton<CurrencyDatasource>((i) => CurrencyDatasourceImpl(i()));
    
    // REPOSITORY
    CoreBinding.registerLazySingleton<CardRepository>( (i) => CardRepositoryImpl(i()));
    CoreBinding.registerLazySingleton<RepositoryAccount>((i) => RepositoryAccountImpl(i()));
    CoreBinding.registerLazySingleton<CurrencyRepostory>((i) => CurrencyRepostoryImpl(i()));

    // USECASE
    CoreBinding.registerLazySingleton<GetAllAccountsBankUsecase>((i) => GetAllAccountsBankUsecaseImpl(i()));
    CoreBinding.registerLazySingleton<GetCardByIdUsecase>((i) => GetCardByIdUsecaseImpl(i()));
    CoreBinding.registerLazySingleton<GetCurrencyUsecase>((i) => GetCurrencyUsecaseImpl(i()));

    // BLOC
    CoreBinding.registerLazySingleton((i) => ListAccountsBankBloc(i()));
    CoreBinding.registerFactory<GetCardBloc>((i)=> GetCardBloc(i()));
    CoreBinding.registerFactory<GetCurrencyBloc>((i)=> GetCurrencyBloc(i()));

  };

  @override
  String get microAppName =>AppRoutes.transactions.microAppName;

  @override
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.transactions.reviewNewRecharge : (ctx,args) => const ReviewNewRechargePage(),

  };

}