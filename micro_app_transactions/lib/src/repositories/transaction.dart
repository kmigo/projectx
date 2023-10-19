import 'package:micro_core/micro_core.dart';

import '../datasource/transaction.dart';
import '../models/transaction_send.dart';

abstract class TransactionRepository {
  Future<Either<Failure,void>> createTransaction(TransactionSend transaction);
}

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionDatasource _transactionDatasource;
  TransactionRepositoryImpl(this._transactionDatasource);
  @override
  Future<Either<Failure,void>> createTransaction(TransactionSend transaction) async {
    try {
      await _transactionDatasource.createTransaction(transaction);
      return const Right(null);
    } on Failure catch (e) {
      return Left(Failure(message: e.message, e: e.toString()));
    } catch (e) {
      return Left(Failure(message:genericError.message ,e: e.toString()));
    }
  }
}