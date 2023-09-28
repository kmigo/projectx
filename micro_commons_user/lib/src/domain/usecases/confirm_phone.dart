
part of 'usecases.dart';

abstract class ConfirmPhoneUsecase {
Future<Either<Failure,void>> call(SmsCodeModel code);
}
class ConfirmPhoneUsecaseImpl extends ConfirmPhoneUsecase {
  final AuthenticationRepository _repository;

  ConfirmPhoneUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call(SmsCodeModel code) async {
   return await _repository.confirmPhone(code);
  }

}