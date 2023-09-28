part of 'usecases.dart';
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