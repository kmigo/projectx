

import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_core/micro_core.dart';



abstract class CardDatasource {

  Future<void> createCard(CardModel card);
}

class CardDatasourceImpl implements CardDatasource {
  final ClientHttp _clientHttp;

  CardDatasourceImpl(this._clientHttp);
  @override
  Future<void> createCard(CardModel card) async{
     await _clientHttp.post(HttpRoutes.cards.card, json: card.toMap());

  }
 
  }