

import 'dart:developer';

import 'package:micro_core/micro_core.dart';





import 'favorite_datasource.dart';

class FavoriteUserdatasourceImpl extends FavoriteUserDatasource {
  final FirebaseDatabase _db;
  FavoriteUserdatasourceImpl(this._db);
  @override
  Future<FavoriteUserEntity> addFavoriteUser(String currentUid, String userUid,
      FavoriteUserModel favoriteModel) async {
    //final doc = await _db.ref(constants.user).child(uid).get();
    log('$currentUid $userUid ${favoriteModel.toMap()}' );
    final doc = await _db
        .ref(constantsUser)
        .child(currentUid)
        .child(constantsfavoriteUsers)
        .child(userUid)
        .get();
    if (doc.exists) {
      log('Usuario existe' );
      throw ErrorFavoriteUserAlreadyExists(message: 'Usuário já é favorito');
    }
    final favId = _db
        .ref(constantsUser)
        .child(currentUid)
        .child(constantsfavoriteUsers)
        .push()
        .key;
     log('favId : $favId' );
    await _db
        .ref(constantsUser)
        .child(currentUid)
        .child(constantsfavoriteUsers)
        .child(favId!)
        .set(favoriteModel.toMap()
          ..['uid'] = userUid
          ..['id'] = favId);
          log('salvou');
    return FavoriteUserEntity(
      uid: userUid,
      id: favId,
      surname: favoriteModel.surname,
    );
  }

  @override
  Future<List<FavoriteUserEntity>> getFavoriteUsers(
      String currentUserId) async {
    final doc = await _db
        .ref(constantsUser)
        .child(currentUserId)
        .child(constantsfavoriteUsers)
        .get();
    final list = <FavoriteUserEntity>[];
    if (doc.exists) {
      final map = doc.value as Map<dynamic, dynamic>;
      map.forEach((key, value) {
        list.add(FavoriteUserDTO.fromMap(value));
      });
    }
    return list;
  }

  @override
  Future<void> removeFavoriteUser(
      String currentUid, String favoriteUserUid) async {
    final doc = await _db
        .ref(constantsUser)
        .child(currentUid)
        .child(constantsfavoriteUsers)
        .child(favoriteUserUid)
        .get();
    if (!doc.exists) {
      throw UserNotFound(message: 'Usuário não encontrado');
    }
    await _db
        .ref(constantsUser)
        .child(currentUid)
        .child(constantsfavoriteUsers)
        .child(favoriteUserUid)
        .remove();
  }

  @override
  Future<void> updateFavoriteUser(String currentUid, String favoriteUserUid,
      FavoriteUserModel favoriteModel) async {
    final doc = await _db
        .ref(constantsUser)
        .child(currentUid)
        .child(constantsfavoriteUsers)
        .child(favoriteUserUid)
        .get();
    if (!doc.exists) {
      throw UserNotFound(message: 'Usuário não encontrado');
    }
    await _db
        .ref(constantsUser)
        .child(currentUid)
        .child(constantsfavoriteUsers)
        .child(favoriteUserUid)
        .update(favoriteModel.toMap());
  }
}
