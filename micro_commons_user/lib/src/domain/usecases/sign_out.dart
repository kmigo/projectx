

part of 'usecases.dart';

abstract class SignOutUsecase {
  Future<Either<Failure,void>> call();
}


class SignOutUsecaseImpl extends SignOutUsecase {
  final AuthenticationRepository _repository;
  SignOutUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call() async {
    return await _repository.signOut();
  }
}