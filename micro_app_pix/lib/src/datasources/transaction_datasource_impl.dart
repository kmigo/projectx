



import 'package:micro_core/micro_core.dart';

import '../domain/entities/transactions.dart';
import '../domain/entities/validate_key.dart';
import '../models/transaction_pix_model.dart';
import 'transaction_datasource.dart';

class TransactionDatasourceImpl extends TransactionDatasource {
  final ClientHttp _client;

  TransactionDatasourceImpl(this._client);
 @override
  Future<TransactionEntity> createPix(TransactionPixModel transaction) async{
     final result = await _client.post(HttpRoutes.transaction.pixCashout,json: transaction.toMap());
    return TransactionDTO.fromMap(result.data);
  }


   @override
  Future<ValidateKeyEntity> validateKey(String key,String type) async{
    final data = {"value":key.replaceAll("%20", ' '),"type":type};
    final headers = <String,dynamic>{
      'x-api-key':EnvironmentVariables.getVariable(VarEnvs.xapikey)
    } ;
    final result = await _client.post(HttpRoutes.transaction.validateKey,json:data,headers: headers);
    return ValidateKeyDTO.fromMap(result.data);
  }

}
