part of 'usecases.dart';
abstract class ChangePincodeUsecase {
  Future<Either<Failure,void>> call(String code);
}
class ChangePincodeUsecaseImpl extends ChangePincodeUsecase {
  final AuthenticationRepository _repository;
  ChangePincodeUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call(String code) async{
    return await _repository.changePincode(CryptoHelper.encryptValue(code ));
  }

}