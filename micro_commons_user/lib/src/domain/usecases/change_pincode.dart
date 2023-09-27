

import 'package:micro_core/micro_core.dart';

import '../../repository/authentication_repository.dart';
abstract class ChangePincodeUsecase {
  Future<Either<Failure,void>> call(String code);
}
class ChangePincodeUsecaseImpl extends ChangePincodeUsecase {
  final AuthenticationRepository _repository;
  ChangePincodeUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call(String code) async{
    return await _repository.changePincode(encrypted(code, EnvironmentVariables.getVariable(VarEnvs.secret) ));
  }

}