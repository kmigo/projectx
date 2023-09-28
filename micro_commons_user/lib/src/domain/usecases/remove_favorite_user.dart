part of 'usecases.dart';

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