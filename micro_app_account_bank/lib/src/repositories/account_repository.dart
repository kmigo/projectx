import 'package:micro_app_account_bank/src/models/account_create_model.dart';
import 'package:micro_core/micro_core.dart';

import '../datasource/account_datasource.dart';

abstract class RepositoryAccount {
  Future<Either<Failure,void>> createBankAccount(AccountCreateModel account);
}

class RepositoryAccountImpl implements RepositoryAccount {
  final AccountDatasource datasource;

  RepositoryAccountImpl(this.datasource);

  @override
  Future<Either<Failure, void>> createBankAccount(AccountCreateModel account) async {
    try {
      await datasource.createBankAccount(account);
      return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}