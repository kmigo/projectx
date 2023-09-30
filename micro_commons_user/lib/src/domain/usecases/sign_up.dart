part of 'usecases.dart';

abstract class SignUpUsecase {
  Future<Either<Failure,UserEntity>> call(SignUpModel userCreateModel ,String pincodeConfirm);
}

class SignUpUsecaseImpl extends SignUpUsecase {
  final AuthenticationRepository _repository;

  SignUpUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call(
      SignUpModel userCreateModel,String pincodeConfirm) async {
        if(userCreateModel.pincode == null) return Left(Failure(message: 'O pincode é obrigatório'));
    if (userCreateModel.pincode!.length  != 6) {
      return  Left(Failure(message: 'O pincode deve conter 6 digitos'));
    }
    if(pincodeConfirm != userCreateModel.pincode){
      return  Left(Failure(message: 'O pincode não confere'));
    }
    return await _repository.signUp(userCreateModel.copyWith(
        pincode: encrypted(userCreateModel.pincode!,
            EnvironmentVariables.getVariable(VarEnvs.secret).toString())));
  }
}
