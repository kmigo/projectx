
import 'package:micro_core/micro_core.dart';

import '../datasource/account_datasource.dart';
import '../domain/entities/account_entity.dart';


abstract class RepositoryAccount {

  Future<Either<Failure,List<AccountBankEntity>>> getBankAccounts();
}

class RepositoryAccountImpl implements RepositoryAccount {
  final AccountDatasource datasource;

  RepositoryAccountImpl(this.datasource);

  
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