import 'package:micro_app_account_bank/src/models/account_create_model.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/usecases/create_account_bank.dart';

part 'state.dart';

class RegisterAccountBankBloc extends Cubit<RegisterAccountBankState> {
  final CreateBankAccountUsecase _createBankAccountUsecase;
  RegisterAccountBankBloc(this._createBankAccountUsecase):super(const RegisterAccountBankState());


  create(AccountCreateModel account)async{
    emit(state.copyWith(status: RegisterAccountBankStatus.loading));
    final result = await _createBankAccountUsecase(account);
    result.fold(
      (error) => emit(state.copyWith(status: RegisterAccountBankStatus.error, failure: error.message)),
      (account) => emit(state.copyWith(status: RegisterAccountBankStatus.success))
    );
  }

}