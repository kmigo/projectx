

import 'package:micro_core/micro_core.dart';

import '../../repositories/transaction_repository.dart';
import '../entities/validate_key.dart';

abstract class ValidateKeyUsecase {
  Future<Either<Failure,ValidateKeyEntity>> call(String key, String type);
} 

class ValidateKeyUsecaseImpl extends ValidateKeyUsecase {
  final TransactionRepository _repository;
  ValidateKeyUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, ValidateKeyEntity>> call(String key, String type) async{
    return await _repository.validateKey(key, type);
  }
}