
import 'package:micro_core/micro_core.dart';


import '../domain/entities/transactions.dart';
import '../domain/entities/validate_key.dart';
import '../models/transaction_pix_model.dart';

abstract class TransactionRepository {
  Future<Either<Failure,TransactionEntity>> createPix(TransactionPixModel transaction);
  Future<Either<Failure,ValidateKeyEntity>> validateKey(String key, String type);

}