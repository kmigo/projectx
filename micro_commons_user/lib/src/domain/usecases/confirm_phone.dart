
import 'package:micro_core/micro_core.dart';

import '../../repository/authentication_repository.dart';
import '../entities/user.dart';

abstract class ConfirmPhoneUsecase {
Future<Either<Failure,UserEntity>> call(String code);
}
class ConfirmPhoneUsecaseImpl extends ConfirmPhoneUsecase {
  final AuthenticationRepository _repository;

  ConfirmPhoneUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call(String code) async {
   return await _repository.confirmPhone(code);
  }

}