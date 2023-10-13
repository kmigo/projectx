part of '../domain/entities/card_entity.dart';

extension CardDTO on CardEntity{
    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'origin_account_id': originAccountId,
      'receiver_account_id': receiverAccountId,
      'name': name,
      'user_id': userId,
    };
  }

  static CardEntity fromMap(Map<String, dynamic> map) {
    return CardEntity(
      originAccountId: map['origin_account_id'] as String,
      receiverAccountId: map['receiver_account_id'] as String,
      name: map['name'] as String,
      userId: map['user_id'] as String,
    );
  }
}