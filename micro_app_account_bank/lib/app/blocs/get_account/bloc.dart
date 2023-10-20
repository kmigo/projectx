import 'package:micro_app_account_bank/src/domain/entities/account_entity.dart';
import 'package:micro_app_account_bank/src/models/account_create_model.dart';
import 'package:micro_app_account_bank/src/usecases/get_account_bank.dart';
import 'package:micro_app_account_bank/src/usecases/update_account.dart';
import 'package:micro_core/micro_core.dart';
part 'state.dart';

class GetAccountBloc extends Cubit<GetAccountState> {
  final GetAccountBankUsecase _getCardUsecase;
  final UpdateAccountUsecase _updateCardUsecase;
  GetAccountBloc(this._getCardUsecase,this._updateCardUsecase):super( const GetAccountState(status: GetAccountStatus.idle));

  getById(String id){
    emit(state.copyWith(status: GetAccountStatus.loading));
    _getCardUsecase(id).then((result) {
      result.fold((l) {
        emit(state.copyWith(status: GetAccountStatus.error));
      }, (r) {
        emit(state.copyWith(status: GetAccountStatus.success, account: r));
      });
    });
  }
  

  update(AccountCreateModel cardModel,String id){
    emit(state.copyWith(status: GetAccountStatus.loading));
    _updateCardUsecase(cardModel,id).then((result) {
      result.fold((l) {
        emit(state.copyWith(status: GetAccountStatus.error,failure: l));
      }, (r) {
        emit(state.copyWith(status: GetAccountStatus.updated));
      });
    });
  }

}