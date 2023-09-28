part of 'usecases.dart';

abstract class VerifySmsCodeUpdatePhoneNumberUsecase {
  Future<Either<Failure,void>> call(SmsCodeModel smscode);
}

class VerifySmsCodeUpdatePhoneNumberUsecaseImpl extends VerifySmsCodeUpdatePhoneNumberUsecase {
  final AuthenticationRepository _authenticationRepository;

  VerifySmsCodeUpdatePhoneNumberUsecaseImpl(this._authenticationRepository);
  @override
  Future<Either<Failure, void>> call(SmsCodeModel smscode) async {
   return await _authenticationRepository.updatePhone(smscode);
  }
  
} 