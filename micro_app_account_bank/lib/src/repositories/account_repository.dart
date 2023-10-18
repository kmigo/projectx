import 'package:micro_app_account_bank/src/domain/entities/account_entity.dart';
import 'package:micro_app_account_bank/src/models/account_create_model.dart';
import 'package:micro_core/micro_core.dart';

import '../datasource/account_datasource.dart';


abstract class RepositoryAccount {
  Future<Either<Failure,void>> createBankAccount(AccountCreateModel account);
  Future<Either<Failure,List<AccountBankEntity>>> getBankAccounts();
}

class RepositoryAccountImpl implements RepositoryAccount {
  final AccountDatasource datasource;

  RepositoryAccountImpl(this.datasource);

  @override
  Future<Either<Failure, void>>createBankAccount(AccountCreateModel account) async {
    try {
      await datasource.createBankAccount(account);
      return const Right(null);
    } on Failure catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      
      return Left(Failure(message: genericError.message));
    }
  }
  
  @override
  Future<Either<Failure,List<AccountBankEntity>>> getBankAccounts() async{
    try{
      return Right(await datasource.getBankAccounts());
    }on Failure catch(e){
      return Left(Failure(message: e.message));
    }catch(e){
      return Left(Failure(message: genericError.message,e: e));
    }
  }
  

}