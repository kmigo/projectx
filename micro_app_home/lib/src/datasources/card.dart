import 'package:micro_app_home/src/domain/entities/card.dart';
import 'package:micro_core/micro_core.dart';

abstract class CardDatasource {
  Future<List<CardEntity>> getCards();
}

class CardDatasourceImpl implements CardDatasource {
  final ClientHttp _clientHttp;
  CardDatasourceImpl(this._clientHttp);
  @override
  Future<List<CardEntity>> getCards() async{
    final result = await _clientHttp.get(HttpRoutes.cards.card);
    return result.data.map<CardEntity>((e) => CardDTO.fromMap(e)).toList();
  }
  
  }