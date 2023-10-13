import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_core/micro_core.dart';

import '../repositories/account_repository.dart';

abstract class CreateCardUsecase {
  Future<Either<Failure,void>> call(CardModel model);
}

class CreateCardUsecaseImpl implements CreateCardUsecase {
  final RepositoryAccount repository;

  CreateCardUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(CardModel model) async{
    return await repository.createCard(model);
  }
}