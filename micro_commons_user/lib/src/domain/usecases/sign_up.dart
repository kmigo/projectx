
import 'package:micro_core/micro_core.dart';

import '../../models/user_create.dart';
import '../../repository/authentication_repository.dart';
import '../entities/user.dart';

abstract class SignUpUsecase {
  Future<Either<Failure,UserEntity>> call(UserCreateModel userCreateModel);
}

class SignUpUsecaseImpl extends SignUpUsecase {
  final AuthenticationRepository _repository;

  SignUpUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call(
      UserCreateModel userCreateModel) async {
    if (userCreateModel.password.length < 6 ||
        userCreateModel.password.length > 6) {
      return  Left(Failure(message: 'O pincode deve conter 6 digitos'));
    }
    return await _repository.signUp(userCreateModel.copyWith(
        password: encrypted(userCreateModel.password,
            EnvironmentVariables.getVariable(VarEnvs.secret).toString())));
  }
}
