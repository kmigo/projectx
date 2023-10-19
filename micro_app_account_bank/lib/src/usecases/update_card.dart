import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_core/micro_core.dart';

import '../repositories/card.dart';

abstract class UpdateCardUsecase {
  Future<Either<Failure,void>> call(CardModel model, String id);
}


class UpdateCardUsecaseImpl implements UpdateCardUsecase {
  final CardRepository _cardRepository;
  UpdateCardUsecaseImpl(this._cardRepository);
  @override
  Future<Either<Failure,void>> call(CardModel model, String id) async {
    return await _cardRepository.updateCard(model, id);
    }
  }