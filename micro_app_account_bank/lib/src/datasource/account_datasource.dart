

import 'package:micro_core/micro_core.dart';

import '../models/account_create_model.dart';

abstract class AccountDatasource {
  Future<void> createBankAccount(AccountCreateModel bankAccount);
}

class AccountDatasourceImpl implements AccountDatasource {
  final ClientHttp _clientHttp;
  AccountDatasourceImpl(this._clientHttp);
  @override
  Future<void> createBankAccount(AccountCreateModel bankAccount) async {
    await _clientHttp.post(HttpRoutes.accountBank.account, json: bankAccount.toMap());
  }
}