
import 'package:micro_app_extract/src/args/transaction.dart';
import 'package:micro_app_extract/src/datasources/transaction_datasource.dart';
import 'package:micro_app_extract/src/domain/entities/transactions.dart';
import 'package:micro_core/micro_core.dart';

class TransactionDatasourceImpl extends TransactionDatasource {
  final ClientHttp _client;

  TransactionDatasourceImpl(this._client);


  @override
  Future<List<TransactionEntity>> getAllTransactions(MyTransactionsQueryArgs? args) async {
    final result = await _client.get(HttpRoutes.transaction.myTransactions,queryString: args?.toMap());

    return (result.data as List).map<TransactionEntity>((e) => TransactionDTO.fromMap(e)).toList();
  }

  
  @override
  Future<TransactionEntity> getTransactionById(String transactionId) async{
    final result = await _client.get("${HttpRoutes.transaction.root}/$transactionId");
    return TransactionDTO.fromMap(result.data);
  }

}
