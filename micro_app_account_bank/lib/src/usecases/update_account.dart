import 'package:micro_core/micro_core.dart';

import '../models/account_create_model.dart';
import '../repositories/account_repository.dart';

abstract class UpdateAccountUsecase {
  Future<Either<Failure, void>> call(AccountCreateModel account,String id);
}

class UpdateAccountUsecaseImpl extends UpdateAccountUsecase {
  final RepositoryAccount _repositoryAccount;

  UpdateAccountUsecaseImpl(this._repositoryAccount);
  @override
  Future<Either<Failure, void>> call(AccountCreateModel account, String id) async{
  
    return  await _repositoryAccount.updateBankAccount(account, id);
     
  }

}