import 'package:micro_core/micro_core.dart';

import '../domain/entities/account_entity.dart';
import '../repositories/account_repository.dart';

abstract class GetAccountBankUsecase {
  Future<Either<Failure,AccountBankEntity>> call(String id);
}

class GetAccountBankUsecaseImpl implements GetAccountBankUsecase {
  final RepositoryAccount _repositoryAccount;
  GetAccountBankUsecaseImpl(this._repositoryAccount);
  @override
  Future<Either<Failure,AccountBankEntity>> call(String id) async {
    return await _repositoryAccount.getAccount(id);
    }
  }