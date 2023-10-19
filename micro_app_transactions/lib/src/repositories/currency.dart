import 'package:micro_app_transactions/src/datasource/currency.dart';
import 'package:micro_app_transactions/src/domain/entities/currency.dart';
import 'package:micro_app_transactions/src/models/currency.dart';
import 'package:micro_core/micro_core.dart';

abstract class CurrencyRepostory {
  Future<Either<Failure,CurrencyEntity>> getCurrency(CurrencyModel currencyEntity);
}

class CurrencyRepostoryImpl extends CurrencyRepostory {
  final CurrencyDatasource _datasource;

  CurrencyRepostoryImpl(this._datasource);
  @override
  Future<Either<Failure, CurrencyEntity>> getCurrency(CurrencyModel currencyEntity) async {
    try{
      final result = await _datasource.getCurrency(currencyEntity);
      return Right(result);
    }on Failure catch(e){
      return Left(Failure(message: e.message));
    }catch(e){
      return Left(Failure(message: genericError.message));
    }
  }

}