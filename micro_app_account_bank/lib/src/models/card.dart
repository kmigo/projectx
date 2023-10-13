

import 'package:micro_core/micro_core.dart';

class CardModel extends Equatable {
  final String originAccountId;
  final String receiverAccountId;
  final String name;
  final String userId;
  const CardModel({
    required this.originAccountId,
    required this.receiverAccountId,
    required this.name,
    required this.userId,
  });
  
  @override
  List<Object?> get props => [originAccountId, receiverAccountId, name, userId];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'origin_account_id': originAccountId,
      'receiver_account_id': receiverAccountId,
      'name': name,
      'user_id': userId,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      originAccountId: map['originAccountId'] as String,
      receiverAccountId: map['receiverAccountId'] as String,
      name: map['name'] as String,
      userId: map['userId'] as String,
    );
  }


  CardModel copyWith({
    String? originAccountId,
    String? receiverAccountId,
    String? name,
    String? userId,
  }) {
    return CardModel(
      originAccountId: originAccountId ?? this.originAccountId,
      receiverAccountId: receiverAccountId ?? this.receiverAccountId,
      name: name ?? this.name,
      userId: userId ?? this.userId,
    );
  }
}
