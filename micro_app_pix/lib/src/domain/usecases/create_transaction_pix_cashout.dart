

import 'package:micro_core/micro_core.dart';

import '../../models/transaction_pix_model.dart';
import '../../repositories/transaction_repository.dart';
import '../entities/transactions.dart';

abstract class CreateTransactionPixCashoutUsecase {
  Future<Either<Failure, TransactionEntity>> call(TransactionPixModel transaction);
}
class CreateTransactionPixCashoutUsecaseImpl extends CreateTransactionPixCashoutUsecase {
  final TransactionRepository _repository;
  CreateTransactionPixCashoutUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, TransactionEntity>> call(TransactionPixModel transaction) async{
    return await _repository.createPix(transaction);
  }

}