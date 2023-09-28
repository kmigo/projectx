part of 'usecases.dart';

abstract class FetchFavoriteUsersUsecase {
  Future<Either<Failure, List<FavoriteUserEntity>>> call(String currentUser);
}

class FetchFavorietsUsersUsecaseImpl extends FetchFavoriteUsersUsecase {
  final FavoriteUserRepository _repository;

  FetchFavorietsUsersUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, List<FavoriteUserEntity>>> call(
      String currentUser) async {
    return await _repository.getFavoriteUsers(currentUser);
  }
}
