
part of 'usecases.dart';

abstract class ConfirmPhoneUsecase {
Future<Either<Failure,void>> call(SmsCodeModel code,[bool update =false]);
}
class ConfirmPhoneUsecaseImpl extends ConfirmPhoneUsecase {
  final AuthenticationRepository _repository;

  ConfirmPhoneUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call(SmsCodeModel code,[bool update =false]) async {
   return await _repository.confirmPhone(code,update);
  }

}