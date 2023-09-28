

import 'package:micro_core/micro_core.dart';

import '../../micro_commons_user.dart';
import '../domain/entities/favorite_user.dart';



abstract class FavoriteUserRepository {
   Future<Either<Failure,FavoriteUserEntity>> addFavoriteUser(String currentUid, String userUid,FavoriteUserModel favoriteModel);
  Future<Either<Failure,void>> removeFavoriteUser(String currentUid,String  favoriteUserUid);
  Future<Either<Failure,List<FavoriteUserEntity>>> getFavoriteUsers(String currentUserId);
  Future<Either<Failure,void>> updateFavoriteUser(String currentUid,String  favoriteUserUid,FavoriteUserModel favoriteModel);
}