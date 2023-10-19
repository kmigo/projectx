import 'package:micro_app_transactions/src/models/transaction_send.dart';
import 'package:micro_app_transactions/src/repositories/transaction.dart';
import 'package:micro_core/micro_core.dart';

abstract class CreateTransactionUsecase {
  Future<Either<Failure,void>> call(TransactionSend transaction);
}

class CreateTransactionUsecaseImpl implements CreateTransactionUsecase {
  final TransactionRepository _transactionDatasource;
  CreateTransactionUsecaseImpl(this._transactionDatasource);
  @override
  Future<Either<Failure,void>> call(TransactionSend transaction) async {
    return await _transactionDatasource.createTransaction(transaction);
    }
  }