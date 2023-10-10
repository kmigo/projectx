import 'package:micro_app_account_bank/src/domain/entities/account_entity.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/usecases/get_all_accounts_bank.dart';

part 'state.dart';

class ListAccountsBankBloc extends Cubit<ListAccountBankState> {
  final GetAllAccountsBankUsecase _getAllAccountsBankUsecase;
  ListAccountsBankBloc(this._getAllAccountsBankUsecase):super(const ListAccountBankState());

  Future<void> getAllAccountsBank() async {
    emit(state.copyWith(status: ListAccountsBankStatus.loading));
    final result = await _getAllAccountsBankUsecase();
    result.fold((l) => emit(state.copyWith(
      status: ListAccountsBankStatus.error,
      failure: l
    )),
     (r) => emit(
      state.copyWith(
        status: ListAccountsBankStatus.success,
        accountsBank: r
      )
     ));
  }

}