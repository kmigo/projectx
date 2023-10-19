

import 'package:micro_app_account_bank/src/domain/entities/card.dart';
import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_core/micro_core.dart';



abstract class CardDatasource {

  Future<void> createCard(CardModel card);
  Future<CardEntity> getCard(String id);
  Future<void> updateCard(CardModel card,String id);
}

class CardDatasourceImpl implements CardDatasource {
  final ClientHttp _clientHttp;

  CardDatasourceImpl(this._clientHttp);
  @override
  Future<void> createCard(CardModel card) async{
     await _clientHttp.post(HttpRoutes.cards.card, json: card.toMap());

  }
  
  @override
  Future<CardEntity> getCard(String id) async{
    final result = await _clientHttp.get("${HttpRoutes.cards.card}/$id");
    return CardDTO.fromMap(result.data);
  }
  
  @override
  Future<void> updateCard(CardModel card,String id) async{
    await _clientHttp.put("${HttpRoutes.cards.card}/$id", json: card.toMap());
  }
 
  }