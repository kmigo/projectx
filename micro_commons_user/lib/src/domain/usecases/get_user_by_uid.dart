import 'package:micro_core/micro_core.dart';

import '../../repository/authentication_repository.dart';
import '../entities/user.dart';

abstract class GetUserByUidUsecase {
  Future<Either<Failure,UserEntity>> call(String uid);
}
class GetUserByUidUsecaseImpl extends GetUserByUidUsecase {
  final AuthenticationRepository _repository;
  GetUserByUidUsecaseImpl(
     this._repository,
  );
  
  @override
  Future<Either<Failure, UserEntity>> call(String uid) async {
    return await _repository.getUserByUid(uid);
  }

}
