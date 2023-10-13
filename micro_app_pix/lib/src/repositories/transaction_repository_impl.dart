



import 'package:micro_core/micro_core.dart';

import '../datasources/transaction_datasource.dart';
import '../domain/entities/transactions.dart';
import '../domain/entities/validate_key.dart';
import '../models/transaction_pix_model.dart';
import 'transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionDatasource _datasource;
  TransactionRepositoryImpl(this._datasource);


  @override
  Future<Either<Failure, ValidateKeyEntity>> validateKey(String key, String type)  async{
    try{
      return Right(await _datasource.validateKey(key,type));
    } on Failure catch(e){
      return Left(Failure(message: e.message));
  }catch(e){
    return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
  }
  }
  
   @override
  Future<Either<Failure, TransactionEntity>> createPix(TransactionPixModel transaction) async {
    try{
      return Right(await _datasource.createPix(transaction));
    }on Failure catch(e){
      return Left(Failure(message: e.message));
    }catch(e){
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

}