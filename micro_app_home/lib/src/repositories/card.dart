import 'package:micro_core/micro_core.dart';

import '../datasources/card.dart';
import '../domain/entities/card.dart';

abstract class CardRepository {
  Future<Either<Failure,List<CardEntity>>> getCards();
}


class CardRepositoryImpl implements CardRepository {
  final CardDatasource _datasource;
  CardRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure,List<CardEntity>>> getCards() async{
    try {
      final result = await _datasource.getCards();
      return Right(result);
    } on Failure catch (e) {
      return Left(Failure(message:e.message,e: e ));
    }catch (e) {
      return Left(Failure(message:e.toString(),e: e ));
    }
  }
  
  }