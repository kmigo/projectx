part of 'usecases.dart';

abstract class ValidPincodeUsecase {
  Future<Either<Failure,UserEntity>> call(String code);
}
class ValidPincodeUsecaseImpl extends ValidPincodeUsecase {
  final AuthenticationRepository _repository;

  ValidPincodeUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call(String code)async {
    final result =  await _repository.validPincode(code);
    return result.fold((l) => Left(l), (r) {

      if(code != CryptoHelper.decryptValue(r.password)){
       return Left(Failure(message: 'Pincode inválido'));
      }
      return Right(r.user);
    });
  }

}