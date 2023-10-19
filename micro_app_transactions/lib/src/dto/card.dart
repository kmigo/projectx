part of '../domain/entities/card.dart';


extension ReceiverAccountDTO on ReceiverAccountEntity {
    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created_at': createdAt,
      'credential_id': credentialId,
      'userId': userId,
      'type': type,
      'document': document,
      'data': data.toMap(),
      'id': id,
    };
  }
    ReceiverAccountEntity copyWith({
    int? createdAt,
    String? credentialId,
    String? userId,
    String? type,
    String? document,
    AccountBankReceiverEntity? data,
    String? id,
  }) {
    return ReceiverAccountEntity(
      createdAt: createdAt ?? this.createdAt,
      credentialId: credentialId ?? this.credentialId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      document: document ?? this.document,
      data: data ?? this.data,
      id: id ?? this.id,
    );
  }

  static ReceiverAccountEntity fromMap(Map<String, dynamic> map) {
    return ReceiverAccountEntity(
      createdAt: map['created_at'] as int,
      credentialId: map['credential_id'] != null ? map['credential_id'] as String : null,
      userId: map['user_id'] as String,
      type: map['type'] as String,
      document: map['document'] != null ? map['document'] as String : null,
      data: AccountBankReceiverDTO.fromMap(map['data']..['id']=map['id']),
      id: map['id'] as String,
    );
  }


}


extension ReceiverAccountBankDetailDTO on ReceiverAccountBankDetailEntity {
   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'keyAccountPix': keyAccountPix,
      'beneficiaryName': beneficiaryName,
      'type': type,
      'tagName': tagName,
      'typeBeneficiary': typeBeneficiary,
      'typeKeyAccountPix': typeKeyAccountPix,
      'id':id
    };
  }

  static ReceiverAccountBankDetailEntity fromMap(Map<String, dynamic> map) {
    return ReceiverAccountBankDetailEntity(
      keyAccountPix: map['keyAccountPix'] != null ? map['keyAccountPix'] as String : '',
      beneficiaryName: map['beneficiaryName'] != null ? map['beneficiaryName'] as String : '',
      type: map['type'] != null ? map['type'] as String : '',
      tagName: map['tagName'] != null ? map['tagName'] as String : '',
      typeBeneficiary: map['typeBeneficiary'] != null ? map['typeBeneficiary'] as String : '',
      typeKeyAccountPix: map['typeKeyAccountPix'] != null ? map['typeKeyAccountPix'] as String : '',
      id: map['id'] != null ? map['id'] as String : '',
    );
  }
}


extension OriginAccountDTO on OriginAccountEntity {
    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created_at': createdAt,
      'credential_id': credentialId,
      'user_id': userId,
      'type': type,
      'document': document,
      'data': data.toMap(),
      'id': id,
    };
  }

   OriginAccountEntity copyWith({
    int? createdAt,
    String? credentialId,
    String? userId,
    String? type,
    String? document,
    AccountBankOriginEntity? data,
    String? id,
  }) {
    return OriginAccountEntity(
      createdAt: createdAt ?? this.createdAt,
      credentialId: credentialId ?? this.credentialId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      document: document ?? this.document,
      data: data ?? this.data,
      id: id ?? this.id,
    );
  }

  static  OriginAccountEntity fromMap(Map<String, dynamic> map) {
    return OriginAccountEntity(
      createdAt: map['created_at'] as int,
      credentialId: map['credential_id'] != null ? map['credential_id'] as String : null,
      userId: map['user_id'] as String,
      type: map['type'] as String,
      document: map['document'] != null ? map['document'] as String : null,
      data: AccountBankOriginDTO.fromMap(map['data']..['id']=map['id']),
      id: map['id'] as String,
    );
  }
}

extension OriginAccountBankDetailDTO on OriginAccountBankDetailEntity{

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'accountNumber': accountNumber,
      'accountHolder': accountHolder,
      'account': account,
      'bankName': bankName,
      'routingNumber': routingNumber,
      'label': label,
      'id':id
    };
  }

  static OriginAccountBankDetailEntity fromMap(Map<String, dynamic> map) {
    return OriginAccountBankDetailEntity(
      type: map['type'] != null ? map['type'] as String : null,
      accountNumber: map['accountNumber'] as String,
      accountHolder: map['accountHolder'] as String,
      account: map['account'] as String,
      id: map['id'] ?? '',
      bankName: map['bankName'] as String,
      routingNumber: map['routingNumber'] as String,
      label: map['label'] as String,
    );
  }
}




extension CardDTO on CardEntity {
   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'receiver_account': receiverAccount.toMap(),
      'origin_account': originAccountEntity.toMap(),
    };
  }

  static  CardEntity fromMap(Map<String, dynamic> map) {
    return CardEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      userId: map['user_id'] as String,
      createdAt: map['created_at'] as int,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as int : null,
      receiverAccount: ReceiverAccountDTO.fromMap(map['receiver_account'] as Map<String,dynamic>),
      originAccountEntity: OriginAccountDTO.fromMap(map['origin_account'] as Map<String,dynamic>),
    );
  }

  
}