
import 'package:micro_core/micro_core.dart';

import '../../repository/authentication_repository.dart';

abstract class RefreshTokenUsecase {
  Future<Either<Failure,void>>call();
}
class RefreshTokenUsecaseImpl extends RefreshTokenUsecase {
  final AuthenticationRepository _repository;

  RefreshTokenUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call() async{
   return await _repository.refreshToken();
  }

}