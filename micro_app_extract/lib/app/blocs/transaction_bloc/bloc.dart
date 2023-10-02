

import 'package:micro_app_extract/src/domain/usecases/get_transaction_by_id.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/domain/entities/transactions.dart';

part 'state.dart';


class TransactionBloc extends Cubit<TransactionState>{
  final GetTransactionByIdUsecase _getTransactionByIdUsecase;
  TransactionBloc(this._getTransactionByIdUsecase):super(const TransactionState.empty());

  getTransactionId(String id)async{
    emit(state.loading());
    final result = await _getTransactionByIdUsecase(id);
    result.fold(
      (l) => emit(state.failure(l.message)),
      (r) => emit(state.success(r))
    );
  }

}