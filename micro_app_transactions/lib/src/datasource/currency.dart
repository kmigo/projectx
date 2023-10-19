import 'package:micro_app_transactions/src/domain/entities/currency.dart';
import 'package:micro_app_transactions/src/models/currency.dart';
import 'package:micro_core/micro_core.dart';

abstract class CurrencyDatasource {
  Future<CurrencyEntity> getCurrency(CurrencyModel currencyModel);
}

class CurrencyDatasourceImpl implements CurrencyDatasource {
  final ClientHttp _clientHttp;
  CurrencyDatasourceImpl(this._clientHttp);
  @override
  Future<CurrencyEntity> getCurrency(CurrencyModel currencyModel) async{
    final result = await _clientHttp.get("${HttpRoutes.transaction.currency}/${currencyModel.currencyIn}/${currencyModel.currencyOut}");
    return CurrencyDTO.fromMap(result.data);
  }
  }