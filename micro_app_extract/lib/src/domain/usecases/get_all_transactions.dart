
import 'package:micro_core/micro_core.dart';

import '../../args/transaction.dart';
import '../../repositories/transaction_repository.dart';
import '../entities/transactions.dart';

abstract class GetAllTransactionsUsecase {
  Future<Either<Failure,List<TransactionEntity>>> call(MyTransactionsQueryArgs? args);
}


class GetAllTransactionsUsecaseImpl extends GetAllTransactionsUsecase {
  final TransactionRepository _repository;
  GetAllTransactionsUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, List<TransactionEntity>>> call(MyTransactionsQueryArgs? args) async{
    return await _repository.getAllTransactions(args);
  }

}