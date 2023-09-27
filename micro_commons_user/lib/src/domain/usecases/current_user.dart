
import 'package:micro_core/micro_core.dart';

import '../../repository/authentication_repository.dart';
import '../entities/user.dart';

abstract class CurrentUserUsecase {
  Future<Either<Failure,UserEntity>> call();
}

class CurrentUserUsecaseImpl extends CurrentUserUsecase {
  final AuthenticationRepository _repository;
  CurrentUserUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call() async {
    return await _repository.currentUser();
  }
}
