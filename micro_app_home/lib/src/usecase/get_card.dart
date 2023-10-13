import 'package:micro_app_home/src/domain/entities/card.dart';
import 'package:micro_core/micro_core.dart';

import '../repositories/card.dart';

abstract class GetCardUsecase {
  Future<Either<Failure,List<CardEntity>>> call();
}


class GetCardUsecaseImpl implements GetCardUsecase {
  final CardRepository _repository;
  GetCardUsecaseImpl(this._repository);
  @override
  Future<Either<Failure,List<CardEntity>>> call() async{
    return await _repository.getCards();
  }
  }