import 'package:micro_app_extract/app/blocs/transaction_bloc/bloc.dart';
import 'package:micro_app_extract/app/pages/extract_home/extract_page.dart';
import 'package:micro_app_extract/app/pages/filter_page/filter_page.dart';
import 'package:micro_app_extract/src/domain/usecases/get_all_transactions.dart';
import 'package:micro_core/micro_core.dart';

import '../src/datasources/transaction_datasource.dart';
import '../src/datasources/transaction_datasource_impl.dart';
import '../src/domain/usecases/get_transaction_by_id.dart';
import '../src/repositories/transaction_repository.dart';
import '../src/repositories/transaction_repository_impl.dart';
import 'blocs/extract/bloc.dart';
import 'blocs/filter_extract/bloc.dart';
import 'pages/show_receipt/extract_receipt_page.dart';

class MicroAppExtractResolver extends MicroApp {
  @override
  void Function() get injectionRegister => () {
        // DATASOURCES
        CoreBinding.registerLazySingleton<TransactionDatasource>(
            (i) => TransactionDatasourceImpl(i()));
        // REPOSITORIES
        CoreBinding.registerLazySingleton<TransactionRepository>(
            (i) => TransactionRepositoryImpl(i()));
        // USECASES
        CoreBinding.registerLazySingleton<GetAllTransactionsUsecase>(
            (i) => GetAllTransactionsUsecaseImpl(i()));
        CoreBinding.registerLazySingleton<GetTransactionByIdUsecase>(
            (i) => GetTransactionByIdImpl(i()));
        // BLOCS
        CoreBinding.registerLazySingleton<ExtractFilterBloc>(
            (i) => ExtractFilterBloc(i(), i()));
        CoreBinding.registerLazySingleton<ExtractBloc>((i) => ExtractBloc(i()));
        CoreBinding.registerLazySingleton<TransactionBloc>((i) => TransactionBloc(i()));
      };

  @override
  String get microAppName => AppRoutes.extract.microAppName;

  @override
  Map<String, WidgetBuildArgs> get routes => {
        AppRoutes.extract.root: (context, args) => const ExtractPage(),
        AppRoutes.extract.extractDetail: (context, args) =>
            const ExtractReceiptPage(),
        AppRoutes.extract.filter: (context, args) => const ExtractFilterPage()
      };
}
