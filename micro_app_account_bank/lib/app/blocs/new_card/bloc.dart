import 'package:micro_app_account_bank/src/domain/entities/card.dart';
import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_app_account_bank/src/usecases/create_card.dart';
import 'package:micro_app_account_bank/src/usecases/get_card.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/usecases/update_card.dart';

part 'state.dart';

class NewCardBloc extends Cubit<NewCardState> {
  final CreateCardUsecase _createCardUsecase;
  final GetCardUsecase _getCardUsecase;
  final UpdateCardUsecase _updateCardUsecase;
  NewCardBloc(this._createCardUsecase,this._getCardUsecase,this._updateCardUsecase) : super(const NewCardState());

  void createCard(CardModel model) async{
    emit(state.copyWith(status: NewCardStatus.loading));
    final result = await _createCardUsecase(model);
    result.fold((l) {
      emit(state.copyWith(status: NewCardStatus.error));
    }, (r) {
      emit(state.copyWith(status: NewCardStatus.success));
    });
    
  }

  getCard(String id)async{
    emit(state.copyWith(status: NewCardStatus.loading));
    final result = await _getCardUsecase(id);
    result.fold((l) {
      emit(state.copyWith(status: NewCardStatus.error));
    }, (r) {
      emit(state.copyWith(status: NewCardStatus.getItem,card: r));
    });
  }

  updateCard(CardModel model,String id)async{
    emit(state.copyWith(status: NewCardStatus.loading));
    final result = await _updateCardUsecase(model, id);
    result.fold((l) {
      emit(state.copyWith(status: NewCardStatus.error));
    }, (r) {
      emit(state.copyWith(status: NewCardStatus.update));
    });
  }



}