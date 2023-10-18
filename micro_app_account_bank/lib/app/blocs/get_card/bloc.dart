import 'package:micro_app_account_bank/src/domain/entities/card.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/usecases/get_card_by_id.dart';

part 'state.dart';

class GetCardBloc extends Cubit<GetCardState> {
  final GetCardByIdUsecase _getCardUsecase;
  GetCardBloc(this._getCardUsecase):super( const GetCardState(status: GetCardStatus.idle));

  getCardById(String id){
    emit(state.copyWith(status: GetCardStatus.loading));
    _getCardUsecase(id).then((result) {
      result.fold((l) {
        emit(state.copyWith(status: GetCardStatus.error));
      }, (r) {
        emit(state.copyWith(status: GetCardStatus.success, card: r));
      });
    });
  }

}