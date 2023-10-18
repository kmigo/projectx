import 'package:micro_core/micro_core.dart';

import '../domain/entities/card.dart';
import '../repositories/card.dart';

abstract class GetCardByIdUsecase {
  Future<Either<Failure,CardEntity>> call(String id);
}

class GetCardByIdUsecaseImpl implements GetCardByIdUsecase {
  final CardRepository repository;
  GetCardByIdUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, CardEntity>> call(String id) async{
    return await repository.getCard(id);
  }
}