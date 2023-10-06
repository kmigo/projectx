part of 'usecases.dart';

abstract class SetPinCodeUsecase {
  Future<Either<Failure,void>> call(SetPinCodeModel setPincode ,String pincodeConfirm);
}

class SetPincodeUsecaseImpl extends SetPinCodeUsecase {
  final AuthenticationRepository _repository;

  SetPincodeUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call(
      SetPinCodeModel setPincode,String pincodeConfirm) async {
        if(setPincode.pincode.isEmpty) return Left(Failure(message: 'O pincode é obrigatório'));
    if (setPincode.pincode.length  != 6) {
      return  Left(Failure(message: 'O pincode deve conter 6 digitos'));
    }
    if(pincodeConfirm != setPincode.pincode){
      return  Left(Failure(message: 'O pincode não confere'));
    }
    return await _repository.setPincode(setPincode.copyWith(
        pincode: CryptoHelper.encryptValue(setPincode.pincode)));
  }
}
