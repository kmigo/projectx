

import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';


import '../datasources/favorite_datasource.dart';



import 'favorite_user_repository.dart';

class FavoriteUserRepositoryImpl extends FavoriteUserRepository {
  final FavoriteUserDatasource _datasource;
  FavoriteUserRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, FavoriteUserEntity>> addFavoriteUser(String currentUid, String userUid, FavoriteUserModel favoriteModel) async{
    try{  
      return Right(await _datasource.addFavoriteUser(currentUid, userUid, favoriteModel));
    }on Failure catch(e){

      return Left(e);
    }catch(e){

      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, List<FavoriteUserEntity>>> getFavoriteUsers(String currentUserId) async{
    try{  
      return Right(await _datasource.getFavoriteUsers(currentUserId));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, void>> removeFavoriteUser(String currentUid, String favoriteUserUid)async {
   try{  
      return Right(await _datasource.removeFavoriteUser(currentUid, favoriteUserUid));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

  @override
  Future<Either<Failure, void>> updateFavoriteUser(String currentUid, String favoriteUserUid, FavoriteUserModel favoriteModel) async{
    try{  
      return Right(await _datasource.updateFavoriteUser(currentUid, favoriteUserUid, favoriteModel));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return Left(Failure(message: genericError.message,e: Exception(e.toString())),);
    }
  }

}