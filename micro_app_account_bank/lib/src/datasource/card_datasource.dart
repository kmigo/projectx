

import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_core/micro_core.dart';

import '../domain/entities/card.dart';

abstract class CardDatasource {
  Future<CardEntity> getCard(String id);
  Future<void> createCard(CardModel card);
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
      final result = await _clientHttp.get('${HttpRoutes.cards.card}/$id');
      return CardDTO.fromMap(result.data);
  }
  }