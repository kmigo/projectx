

import 'package:micro_app_account_bank/src/domain/entities/account_entity.dart';
import 'package:micro_core/micro_core.dart';

import '../models/account_create_model.dart';



abstract class AccountDatasource {
  Future<void> createBankAccount(AccountCreateModel bankAccount);
  Future<List<AccountBankEntity>> getBankAccounts();
}

class AccountDatasourceImpl implements AccountDatasource {
  final ClientHttp _clientHttp;
  AccountDatasourceImpl(this._clientHttp);
  @override
  Future<void> createBankAccount(AccountCreateModel bankAccount) async {
    await _clientHttp.post(HttpRoutes.accountBank.account, json: bankAccount.toMap());
  }
  
  @override
  Future<List<AccountBankEntity>> getBankAccounts() async {
    final result = await _clientHttp.get(HttpRoutes.accountBank.account);
    return  result.data.map<AccountBankEntity>((dynamic e) => AccountDTO.fromMap(e)).toList();
  }


}