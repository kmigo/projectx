

import 'package:micro_app_extract/src/datasources/transaction_datasource.dart';
import 'package:micro_app_extract/src/repositories/transaction_repository.dart';
import 'package:micro_core/micro_core.dart';

import '../args/transaction.dart';
import '../domain/entities/transactions.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionDatasource _datasource;
  TransactionRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions(MyTransactionsQueryArgs? args) async{
     try{
      return Right(await _datasource.getAllTransactions(args));
    }on Failure catch(e){
      return Left(Failure(message: e.message,e: e));
    }catch(e){
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }
  
  @override
  Future<Either<Failure, TransactionEntity>> getTransactionById(String transactionId) async{
    try{
      return Right(await _datasource.getTransactionById(transactionId));
    }on Failure catch(e){
      return Left(Failure(message: e.message,e: e));
    }catch(e){
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

}