







import '../args/transaction.dart';
import '../domain/entities/transactions.dart';

abstract class TransactionDatasource {
  Future<List<TransactionEntity>> getAllTransactions(MyTransactionsQueryArgs? args);
  Future<TransactionEntity> getTransactionById(String transactionId);
}