import 'package:micro_app_account_bank/src/models/account_create_model.dart';
import 'package:micro_core/micro_core.dart';

import '../repositories/account_repository.dart';

abstract class CreateBankAccountUsecase {
  Future<Either<Failure,void>> call(AccountCreateModel account);
  }


class CreateBankAccountUsecaseImpl implements CreateBankAccountUsecase {
  final RepositoryAccount repository;

  CreateBankAccountUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(AccountCreateModel account) async {
    return await repository.createBankAccount(account);
  }
}