import '../../repositories/transaction_repository.dart';

import 'package:micro_core/micro_core.dart';

import '../entities/transactions.dart';
abstract class GetTransactionByIdUsecase {
  Future<Either<Failure,TransactionEntity>> call(String transactionId);
}


class GetTransactionByIdImpl extends GetTransactionByIdUsecase {
  final TransactionRepository _repository;

  GetTransactionByIdImpl(this._repository);
  @override
  Future<Either<Failure, TransactionEntity>> call(String transactionId)async {
    return await _repository.getTransactionById(transactionId);
  }

}

