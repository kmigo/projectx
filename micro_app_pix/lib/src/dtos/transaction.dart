part of '../domain/entities/transactions.dart';

extension TransactionDTO on TransactionEntity {
 
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'expected_amout': expectedAmout,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'type': type,
      'action': action,
      'payer': payer.toMap(),
      'receiver': receiver.toMap(),
      'description': description,
      'identification': identification,
      'operation_id': operationId,
      'credential_id': credentialId,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return TransactionEntity(
      id: map['id'] ?? '',
      amount: map['amount'] ?? 0,
      expectedAmout: map['expected_amout'] ?? 0,
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? 0,
      updatedAt: map['updated_at'] ?? 0,
      type: map['type'] ?? '',
      action: map['action'] ?? '',
      payer:  map['payer'] != null ? UserTransactionDTO.fromMap(map['payer'] as Map<String,dynamic>) : const UserTransactionEntity.empty(),
      receiver: map['receiver'] != null ? UserTransactionDTO.fromMap(map['receiver'] as Map<String,dynamic>) : const UserTransactionEntity.empty(),
      description: map['description'] ?? '',
      identification: map['identification'] ?? '',
      operationId: map['operation_id'] ?? '',
      credentialId: map['credential_id'] ?? '',
    );
  }

}

extension UserTransactionDTO on UserTransactionEntity {
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'user_id': userId,
      'document': document,
      'account_data': accountData.toMap(),
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return UserTransactionEntity(
      name: map['name'] ?? '',
      userId: map['user_id'] ?? '',
      document: map['document'] ?? '',
      accountData: AccountDataDTO.fromMap(map['account_data']),
    );
  }
}

extension AccountDataDTO on AccountDataEntity {
  toMap(){
    return <String, dynamic>{
      'safe_id': safeId,
    };
  }
  static fromMap(Map<String, dynamic>? map) {
    if(map == null) return const AccountDataEntity.empty();
    return AccountDataEntity(
      safeId: map['safe_id'] ?? '',
    );
  }
}