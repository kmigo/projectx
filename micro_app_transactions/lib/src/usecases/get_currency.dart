import 'package:micro_app_transactions/src/domain/entities/currency.dart';
import 'package:micro_app_transactions/src/models/currency.dart';
import 'package:micro_core/micro_core.dart';

import '../repositories/currency.dart';

abstract class GetCurrencyUsecase {
  Future<Either<Failure,CurrencyEntity>> call(CurrencyModel currencyModel);
}

class GetCurrencyUsecaseImpl implements GetCurrencyUsecase {
  final CurrencyRepostory _repostory;
  GetCurrencyUsecaseImpl(this._repostory);
  @override
  Future<Either<Failure, CurrencyEntity>> call(CurrencyModel currencyModel) async{
    return await _repostory.getCurrency(currencyModel);
  }
  
}