part of 'usecases.dart';

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
