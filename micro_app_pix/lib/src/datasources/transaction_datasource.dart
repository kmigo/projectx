







import '../domain/entities/transactions.dart';
import '../domain/entities/validate_key.dart';
import '../models/transaction_pix_model.dart';

abstract class TransactionDatasource {
 Future<TransactionEntity> createPix(TransactionPixModel transaction);
   Future<ValidateKeyEntity> validateKey(String key, String type);
}