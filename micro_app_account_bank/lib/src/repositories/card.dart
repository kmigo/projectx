
import 'package:micro_app_account_bank/src/domain/entities/card.dart';
import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_core/micro_core.dart';

import '../datasource/card_datasource.dart';

abstract class CardRepository {
  Future<Either<Failure,void>> createCard(CardModel cardModel);
  Future<Either<Failure,CardEntity>> getCard(String id);
  Future<Either<Failure,void>> updateCard(CardModel cardModel,String id);


}

class CardRepositoryImpl implements CardRepository {
  final CardDatasource _datasource;
  CardRepositoryImpl(this._datasource);
  
  @override
  Future<Either<Failure, void>> createCard(CardModel cardModel) async {
    
    try{
      final result = await _datasource.createCard(cardModel);
      return Right(result);
    }on Failure catch(e){
      return Left(Failure(message: e.message));
    }catch(e){
      return Left(Failure(message: genericError.message));
    }

  }
  
  @override
  Future<Either<Failure, CardEntity>> getCard(String id) async{
   try{
    return Right(await _datasource.getCard(id));
   }on Failure catch(e){
     return Left(Failure(message: e.message));
  }catch(e){
    return Left(Failure(message: genericError.message));
  }
  
  }
  
  @override
  Future<Either<Failure, void>> updateCard(CardModel cardModel, String id)async {
    try{
      final result = await _datasource.updateCard(cardModel, id);
      return Right(result);
    }on Failure catch(e){
      return Left(Failure(message: e.message));
    }catch(e){
      return Left(Failure(message: genericError.message));
    }
  }
  



}