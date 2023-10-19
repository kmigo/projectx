


import 'package:micro_core/micro_core.dart';

import '../domain/entities/account_entity.dart';




abstract class AccountDatasource {

  Future<List<AccountBankEntity>> getBankAccounts();

  
}

class AccountDatasourceImpl implements AccountDatasource {
  final ClientHttp _clientHttp;
  AccountDatasourceImpl(this._clientHttp);

  
  @override
  Future<List<AccountBankEntity>> getBankAccounts() async {
    final result = await _clientHttp.get(HttpRoutes.accountBank.account);
    return  result.data.map<AccountBankEntity>((dynamic e) => AccountDTO.fromMap(e)).toList();
  }

}