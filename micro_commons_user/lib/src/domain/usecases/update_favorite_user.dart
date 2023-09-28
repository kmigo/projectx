part of 'usecases.dart';

abstract class UpdateFavoriteUserUsecase {
  Future<Either<Failure,void>> call(String currentUid, String favoriteUserUid,FavoriteUserModel favoriteUserModel);
}

class UpdateFavoriteUserUsecaseImpl extends UpdateFavoriteUserUsecase {
  final FavoriteUserRepository _repository;

  UpdateFavoriteUserUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call(String currentUid, String favoriteUserUid, FavoriteUserModel favoriteUserModel) async {
    return await _repository.updateFavoriteUser(currentUid, favoriteUserUid, favoriteUserModel);
  }

}