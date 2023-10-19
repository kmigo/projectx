import 'package:micro_core/micro_core.dart';

import '../domain/entities/account_entity.dart';
import '../repositories/account_repository.dart';

abstract class GetAllAccountsBankUsecase {
  Future<Either<Failure,List<AccountBankEntity>>> call();
  }

class GetAllAccountsBankUsecaseImpl implements GetAllAccountsBankUsecase {
  final RepositoryAccount repository;

  GetAllAccountsBankUsecaseImpl(this.repository);

  @override
  Future<Either<Failure,List<AccountBankEntity>>> call() async {
    return await repository.getBankAccounts();
  }
}