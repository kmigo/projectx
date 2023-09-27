
import 'package:micro_core/micro_core.dart';

import '../../repository/authentication_repository.dart';
import '../entities/user.dart';

abstract class UpdateUserUsecase {
  Future<Either<Failure,void>> call(UserEntity userEntity);
}

class UpdateUserUsecaseImpl extends  UpdateUserUsecase {
  final AuthenticationRepository _repository;
  UpdateUserUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call(UserEntity userEntity) async{
    return await _repository.updateUser(userEntity);
  }

}