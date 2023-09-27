

import '../domain/entities/favorite_user.dart';
import '../models/favorite_user.dart';

abstract class FavoriteUserDatasource {
  Future<FavoriteUserEntity> addFavoriteUser(String currentUid, String userUid,FavoriteUserModel favoriteModel);
  Future<void> removeFavoriteUser(String currentUid,String  favoriteUserUid);
  Future<List<FavoriteUserEntity>> getFavoriteUsers(String currentUserId);
  Future<void> updateFavoriteUser(String currentUid,String  favoriteUserUid,FavoriteUserModel favoriteModel);
}