part of '../domain/entities/favorite_user.dart';

extension FavoriteUserDTO on FavoriteUserEntity {
    

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'surname': surname,
      'id': id,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return FavoriteUserEntity(
      uid: map['uid'] as String,
      id: map['id'] as String,
      surname: map['surname'] as String,
    );
  }

}