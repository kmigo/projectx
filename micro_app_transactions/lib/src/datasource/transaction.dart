import 'package:micro_app_transactions/src/models/transaction_send.dart';
import 'package:micro_core/micro_core.dart';

abstract class TransactionDatasource {
  Future<void>createTransaction(TransactionSend transaction);
}

class TransactionDatasourceImpl implements TransactionDatasource {
  final ClientHttp _clientHttp;
  TransactionDatasourceImpl(this._clientHttp);
  @override
  Future<void> createTransaction(TransactionSend transaction) async {
     await _clientHttp.post( HttpRoutes.transaction.directTransaction,
      json: transaction.toMap(),
    );

  }
  }