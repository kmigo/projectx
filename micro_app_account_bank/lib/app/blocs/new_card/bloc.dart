import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_app_account_bank/src/usecases/create_card.dart';
import 'package:micro_core/micro_core.dart';

part 'state.dart';

class NewCardBloc extends Cubit<NewCardState> {
  final CreateCardUsecase _createCardUsecase;
  NewCardBloc(this._createCardUsecase) : super(const NewCardState());

  void createCard(CardModel model) async{
    emit(state.copyWith(status: NewCardStatus.loading));
    final result = await _createCardUsecase(model);
    result.fold((l) {
      emit(state.copyWith(status: NewCardStatus.error));
    }, (r) {
      emit(state.copyWith(status: NewCardStatus.success));
    });
    
  }

}