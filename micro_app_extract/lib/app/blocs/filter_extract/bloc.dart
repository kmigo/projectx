



import 'package:micro_core/micro_core.dart';


import '../../../src/args/transaction.dart';
import '../../../src/domain/entities/transactions.dart';
import '../../../src/domain/usecases/get_all_transactions.dart';
part 'state.dart';

class ExtractFilterBloc extends Cubit<ExtractFilterState> {
  final GetUserWithKycUsecase _getUserWithKycUsecase;
  final GetAllTransactionsUsecase _getAllTransactions;
  ExtractFilterBloc(this._getAllTransactions,this._getUserWithKycUsecase):super(const ExtractFilterState(transactions: []));

  set setState(ExtractFilterState state) => emit(state);

  getTransactions() async {
    emit(state.copyWith(status: ExtractFilterStatus.loading));
    final result = await _getAllTransactions(state.query);
    result.fold(
        (l) => emit(state.copyWith(status: ExtractFilterStatus.failure,error: l.message)),
        (r) => emit(state.copyWith(status: ExtractFilterStatus.success,transactions: r)));
  }

  getUser()async{
    emit(state.copyWith(status: ExtractFilterStatus.loading));
    final result = await _getUserWithKycUsecase();
    result.fold(
        (l) => emit(state.copyWith(status: ExtractFilterStatus.failure,error: l.message)),
        (r) => emit(state.copyWith(status: ExtractFilterStatus.userFound,userFound: r)));
  }

}
