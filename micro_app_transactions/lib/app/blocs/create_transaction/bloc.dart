import 'package:micro_app_transactions/src/models/transaction_send.dart';
import 'package:micro_app_transactions/src/usecases/create_transaction.dart';
import 'package:micro_core/micro_core.dart';

part 'state.dart';

class CreateTransactionBloc extends Cubit<CreateTransactionState>{
  final CreateTransactionUsecase  _createTransactionUsecase;
  CreateTransactionBloc(this._createTransactionUsecase):super(const CreateTransactionState(status: CreateTransactionStatus.idle,));

  createTransaction(TransactionSend transaction)async{
    emit(state.copyWith(status: CreateTransactionStatus.loading));
    final result = await _createTransactionUsecase(transaction);
    result.fold((l) => emit(state.copyWith(status: CreateTransactionStatus.error,failure: l)), (r) => emit(state.copyWith(status: CreateTransactionStatus.success)));
  }


}