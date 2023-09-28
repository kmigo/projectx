part of 'usecases.dart';
abstract class SignInUsecase {
  Future<Either<Failure,UserEntity>> call(SignInModel signInModel);
}

class SignInUsecaseImpl extends SignInUsecase {
  final AuthenticationRepository _repository;
  SignInUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call(SignInModel signInModel) async{
    return await _repository.signIn(signInModel);
  }

}