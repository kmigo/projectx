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

  static ReceiverAccountEntity fromMap(Map<String, dynamic> map) {
    return ReceiverAccountEntity(
      createdAt: map['created_at'] as int,
      credentialId: map['credential_id'] != null ? map['credential_id'] as String : null,
      userId: map['user_id'] as String,
      type: map['type'] as String,
      document: map['document'] != null ? map['document'] as String : null,
      data: ReceiverAccountBankDetailDTO.fromMap(map['data'] as Map<String,dynamic>),
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

  static  OriginAccountEntity fromMap(Map<String, dynamic> map) {
    return OriginAccountEntity(
      createdAt: map['created_at'] as int,
      credentialId: map['credential_id'] != null ? map['credential_id'] as String : null,
      userId: map['user_id'] as String,
      type: map['type'] as String,
      document: map['document'] != null ? map['document'] as String : null,
      data: OriginAccountBankDetailDTO.fromMap(map['data'] as Map<String,dynamic>),
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
    };
  }

  static OriginAccountBankDetailEntity fromMap(Map<String, dynamic> map) {
    return OriginAccountBankDetailEntity(
      type: map['type'] != null ? map['type'] as String : null,
      accountNumber: map['accountNumber'] as String,
      accountHolder: map['accountHolder'] as String,
      account: map['account'] as String,
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
      'origin_account': originAccountEntity?.toMap(),
    };
  }

  static  CardEntity fromMap(Map<String, dynamic> map) {
    return CardEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      userId: map['user_id'] ,
      createdAt: map['created_at'] ,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as int : null,
      receiverAccount: ReceiverAccountDTO.fromMap(map['receiver_account'] as Map<String,dynamic>),
      //TODO: Ives vai adicionar o origin_account no futuro
      originAccountEntity: null//OriginAccountDTO.fromMap(map['origin_account'] as Map<String,dynamic>),
    );
  }

  
}