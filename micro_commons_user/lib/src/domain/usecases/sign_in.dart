
import 'package:micro_core/micro_core.dart';

import '../../models/sign_in.dart';
import '../../repository/authentication_repository.dart';
import '../entities/user.dart';

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