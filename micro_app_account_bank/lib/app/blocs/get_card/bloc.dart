import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_app_account_bank/src/usecases/get_card.dart';
import 'package:micro_app_account_bank/src/usecases/update_card.dart';
import 'package:micro_core/micro_core.dart';
import '../../../src/domain/entities/card.dart';


part 'state.dart';

class GetCardBloc extends Cubit<GetCardState> {
  final GetCardUsecase _getCardUsecase;
  final UpdateCardUsecase _updateCardUsecase;
  GetCardBloc(this._getCardUsecase,this._updateCardUsecase):super( const GetCardState(status: GetCardStatus.idle));

  Future<void> getCardById(String id)async{
    emit(state.copyWith(status: GetCardStatus.loading));
    await _getCardUsecase(id).then((result) {
      result.fold((l) {
        emit(state.copyWith(status: GetCardStatus.error));
      }, (r) {
        emit(state.copyWith(status: GetCardStatus.success, card: r));
      });
    });
  }
  

  updateCard(CardModel cardModel,String id){
    emit(state.copyWith(status: GetCardStatus.loading));
    _updateCardUsecase(cardModel,id).then((result) {
      result.fold((l) {
        emit(state.copyWith(status: GetCardStatus.error, failure: l));
      }, (r) {
        emit(state.copyWith(status: GetCardStatus.updated));
      });
    });
  }

}