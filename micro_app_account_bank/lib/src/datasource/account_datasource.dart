

import 'package:micro_app_account_bank/src/domain/entities/account_entity.dart';

import 'package:micro_core/micro_core.dart';

import '../models/account_create_model.dart';



abstract class AccountDatasource {
  Future<void> createBankAccount(AccountCreateModel bankAccount);
  Future<List<AccountBankEntity>> getBankAccounts();
  Future<void> updateBankAccount(AccountCreateModel bankAccount,String id);
  Future<AccountBankEntity> getAccount(String id);

  
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
  
  @override
  Future<AccountBankEntity> getAccount(String id) async{
    final result = await _clientHttp.get("${HttpRoutes.accountBank.account}/$id");
    return AccountDTO.fromMap(result.data);
  }
  
  @override
  Future<void> updateBankAccount(AccountCreateModel bankAccount, String id) async {
    await _clientHttp.put("${HttpRoutes.accountBank.account}/$id", json: bankAccount.toMap());
  }

}