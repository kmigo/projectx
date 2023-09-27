
import 'package:micro_core/micro_core.dart';

import '../../repository/favorite_user_repository.dart';
import '../entities/favorite_user.dart';

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
