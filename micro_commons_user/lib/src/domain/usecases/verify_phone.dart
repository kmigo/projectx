part of 'usecases.dart';

abstract class VerifyPhoneUsecase {
  Future<Either<Failure, void>> call(VerifyPhoneModel phoneModel);
}

class VerifyPhoneUsecaseImpl extends VerifyPhoneUsecase {
  final AuthenticationRepository _authenticationRepository;

  VerifyPhoneUsecaseImpl(this._authenticationRepository);
  @override
  Future<Either<Failure, void>> call(VerifyPhoneModel phoneModel) async {


    if (!HelperValidatorMask.validateMaskToNumbers(phoneModel.phoneNumber, phoneModel.phoneItemConfigModel!.mask!)) {
      return Left(Failure(message: 'Telefone inválido'));
    } else {
      final onlyNumber = phoneModel.phoneNumber!.replaceAll(RegExp(r'\D'), '');
      final codeCountry = phoneModel.phoneItemConfigModel!.code;


      return await _authenticationRepository.verifyPhone( phoneModel.copyWith(phoneNumber: '$codeCountry$onlyNumber'));
    }
  }

  
}
