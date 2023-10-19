part of '../domain/entities/account_bank_receiver.dart';

extension AccountBankReceiverDTO on AccountBankReceiverEntity {
    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tagName': tagName,
      'typeBeneficiary': typeBeneficiary,
      'beneficiaryName': beneficiaryName,
      'typeKeyAccountPix': typeKeyAccountPix,
      'keyAccountPix': keyAccountPix,
      'id': id,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    
    return AccountBankReceiverEntity(
      tagName: map['tagName']??'' ,
      typeBeneficiary: map['typeBeneficiary'] ?? '',
      beneficiaryName: map['beneficiaryName'] ?? '',
      id: map['id'],
      typeKeyAccountPix: map['typeKeyAccountPix']??'',
      keyAccountPix: map['keyAccountPix'] ?? '',
    );
  }
}