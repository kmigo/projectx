
import 'package:micro_core/micro_core.dart';

import '../../models/favorite_user.dart';
import '../../repository/favorite_user_repository.dart';
import '../entities/favorite_user.dart';
abstract class AddUserAsFavoriteUsecase {
  Future<Either<Failure, FavoriteUserEntity>> call(String currentUser,String userUid, FavoriteUserModel favoriteModel);
}

class AddUserAsFavoriteUsecaseImpl extends AddUserAsFavoriteUsecase {
  final FavoriteUserRepository _repository;

  AddUserAsFavoriteUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, FavoriteUserEntity>> call(String currentUser, String userUid, FavoriteUserModel favoriteModel)async {
    return await _repository.addFavoriteUser(currentUser, userUid, favoriteModel);
  }

}