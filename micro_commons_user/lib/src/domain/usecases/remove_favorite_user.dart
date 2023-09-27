import 'package:micro_core/micro_core.dart';

import '../../repository/favorite_user_repository.dart';

abstract class RemoveFavoriteUserUsecase{
  Future<Either<Failure,void>> call(String currentUid, String favoriteUserUid);
}

class RemoveFavoriteUserUsecaseImpl extends RemoveFavoriteUserUsecase {
  final FavoriteUserRepository _repository;

  RemoveFavoriteUserUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call(String currentUid, String favoriteUserUid) async {
    return await _repository.removeFavoriteUser(currentUid, favoriteUserUid);
  }

}