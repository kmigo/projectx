import 'package:micro_app_transactions/src/models/currency.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/domain/entities/currency.dart';
import '../../../src/usecases/get_currency.dart';

part 'state.dart';

class GetCurrencyBloc extends Cubit<GetCurrencyState> {
  final GetCurrencyUsecase _getCurrencyUsecase;

  GetCurrencyBloc(this._getCurrencyUsecase):super(const GetCurrencyState(status: GetCurrencyStatus.idle));

  getCurrency(CurrencyModel currency){
    emit(state.copyWith(status: GetCurrencyStatus.loading));
    _getCurrencyUsecase(currency).then((result) {
      result.fold((l) {
        emit(state.copyWith(status: GetCurrencyStatus.error));
      }, (r) {
        emit(state.copyWith(status: GetCurrencyStatus.success, currency: r));
      });
    });
  }

}