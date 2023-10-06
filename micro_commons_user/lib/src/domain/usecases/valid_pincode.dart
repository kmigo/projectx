part of 'usecases.dart';

abstract class ValidPincodeUsecase {
  Future<Either<Failure,UserEntity>> call(String code);
}
class ValidPincodeUsecaseImpl extends ValidPincodeUsecase {
  final AuthenticationRepository _repository;
  final CacheHelper _cacheHelper;
  ValidPincodeUsecaseImpl(this._repository,this._cacheHelper);
  @override
  Future<Either<Failure, UserEntity>> call(String code)async {
    final result =  await _repository.validPincode(code);
    return result.fold((l) => Left(l), (r) {

      if(code != CryptoHelper.decryptValue(r.password)){

       return Left(Failure(message: 'Pincode inválido'));
      }
      _cacheHelper.setBool(StringUtils.pincodeValidation, true);
      return Right(r.user);
    });
  }

}