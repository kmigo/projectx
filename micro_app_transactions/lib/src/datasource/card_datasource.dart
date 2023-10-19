

import 'package:micro_core/micro_core.dart';

import '../domain/entities/card.dart';

abstract class CardDatasource {
  Future<CardEntity> getCard(String id);
}

class CardDatasourceImpl implements CardDatasource {
  final ClientHttp _clientHttp;

  CardDatasourceImpl(this._clientHttp);
  
  @override
  Future<CardEntity> getCard(String id) async{
      final result = await _clientHttp.get('${HttpRoutes.cards.card}/$id');
      return CardDTO.fromMap(result.data);
  }
  }