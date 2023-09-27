import 'package:micro_core/micro_core.dart';


import '../../models/update_phone.dart';
import '../../repository/authentication_repository.dart';

abstract class VerifyToUpdatePhoneUsecase {
  Future<Either<Failure,void>> call(UpdatePhoneModel phoneModel);
}
class VerifyToUpdatePhoneUsecaseImpl extends VerifyToUpdatePhoneUsecase {
  final AuthenticationRepository _authenticationRepository;

  VerifyToUpdatePhoneUsecaseImpl(this._authenticationRepository);
  @override
  Future<Either<Failure, void>> call(UpdatePhoneModel phoneModel)async {
    return await _authenticationRepository.verifyPhoneToUpdate(phoneModel);
  }

}