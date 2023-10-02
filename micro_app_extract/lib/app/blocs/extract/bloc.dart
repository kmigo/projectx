
import 'package:micro_core/micro_core.dart';

import '../../../src/args/transaction.dart';
import '../../../src/domain/entities/transactions.dart';
import '../../../src/domain/usecases/get_all_transactions.dart';


part 'state.dart';

class ExtractBloc extends Cubit<ExtractState> {
  final GetAllTransactionsUsecase _getAllTransactionByUIDUsecase;
  ExtractBloc(this._getAllTransactionByUIDUsecase)
      : super(const ExtractState.empty());

  getTransactions(String uid) async {
    emit(state.loading());
    final result = await _getAllTransactionByUIDUsecase(null);
    result.fold(
        (l) => emit(state.failure(l.message)),
        (r) => emit(state.success(r)));
  }
}