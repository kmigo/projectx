
import 'package:micro_core/micro_core.dart';

import '../src/datasources/transaction_datasource.dart';
import '../src/datasources/transaction_datasource_impl.dart';
import '../src/domain/usecases/create_transaction_pix_cashout.dart';
import '../src/domain/usecases/validate_key.dart';
import '../src/repositories/transaction_repository.dart';
import '../src/repositories/transaction_repository_impl.dart';
import 'pages/select_keys/select_keys_page.dart';


class MicroAppPixTransactionResolver extends MicroApp {
  @override
  void Function() get injectionRegister => (){
    // DATASOURCES
    CoreBinding.registerLazySingleton<TransactionDatasource>((i) => TransactionDatasourceImpl(i()));
    //REPOSITORIES
    CoreBinding.registerLazySingleton<TransactionRepository>((i) => TransactionRepositoryImpl(i()));
    // USECASES
    CoreBinding.registerLazySingleton<CreateTransactionPixCashoutUsecase>((i) => CreateTransactionPixCashoutUsecaseImpl(i()));
    CoreBinding.registerLazySingleton<ValidateKeyUsecase>((i) => ValidateKeyUsecaseImpl(i()));

  };

  @override
  String get microAppName => AppRoutes.pixTransaction.microAppName;
  @override
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.pixTransaction.selectKeys :(context, args) => const SelectKeysPage(),
  };


}