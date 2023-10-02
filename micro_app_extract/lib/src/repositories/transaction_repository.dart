
import 'package:micro_core/micro_core.dart';

import '../args/transaction.dart';
import '../domain/entities/transactions.dart';

abstract class TransactionRepository {
  Future<Either<Failure,List<TransactionEntity>>> getAllTransactions(MyTransactionsQueryArgs? args);
  Future<Either<Failure,TransactionEntity>> getTransactionById(String transactionId);

}