import 'package:micro_app_home/src/usecase/get_card.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/domain/entities/card.dart';

part 'state.dart';

class CardListBloc extends Cubit<CardListState>{
  final GetCardUsecase _getCardUsecase;

  CardListBloc(this._getCardUsecase) : super(const CardListState());

  void getCards() async{
    emit(state.copyWith(status: CardListStatus.loading));
    final result = await _getCardUsecase();
    result.fold((l) {
      emit(state.copyWith(status: CardListStatus.error,failure: l));
    }, (r) {
      emit(state.copyWith(status: CardListStatus.success, cards: r));
    });
  }
}