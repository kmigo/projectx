
import 'package:micro_core/micro_core.dart';

import '../datasource/card_datasource.dart';
import '../domain/entities/card.dart';

abstract class CardRepository {

  Future<Either<Failure,CardEntity>> getCard(String id);
}

class CardRepositoryImpl implements CardRepository {
  final CardDatasource _datasource;
  CardRepositoryImpl(this._datasource);

  
  @override
  Future<Either<Failure, CardEntity>> getCard(String id) async{
    
    try{
      final result = await _datasource.getCard(id);
      return Right(result);
    }on Failure catch(e){
      return Left(Failure(message: e.message));
    }catch(e){
      return Left(Failure(message: genericError.message));
    }
  }


}