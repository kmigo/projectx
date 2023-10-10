part of '/src/domain/entities/account_entity.dart';

extension AccountDTO on AccountBankEntity {
Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'data': data,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static AccountBankEntity fromMap(Map<String, dynamic> map) {
    return AccountBankEntity(
      id: map['id'] != null ? map['id'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      data: map['data'] as dynamic,
      userId: map['userId'] != null ? map['userId'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as int : null,
    );
  }
}