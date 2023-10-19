import 'package:micro_core/micro_core.dart';

import '../domain/entities/card.dart';
import '../repositories/card.dart';

abstract class GetCardUsecase {
  Future<Either<Failure,CardEntity>> call(String id);
}

class GetCardUsecaseImpl implements GetCardUsecase {
  final CardRepository _cardRepository;
  GetCardUsecaseImpl(this._cardRepository);
  @override
  Future<Either<Failure,CardEntity>> call(String id) async {
    return await _cardRepository.getCard(id);
    }
  }