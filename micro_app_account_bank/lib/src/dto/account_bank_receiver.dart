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
    String keyAccount = map['keyAccountPix'] ?? '';
    final typeKey = map['typeKeyAccountPix'] ?? '';
    if(['cpf','cnpj','telefone'].contains(typeKey.toLowerCase())){
      keyAccount = keyAccount.replaceAll(RegExp(r'\D'), '');
    }
    
    return AccountBankReceiverEntity(
      tagName: map['tagName']??'' ,
      typeBeneficiary: map['typeBeneficiary'] ?? '',
      beneficiaryName: map['beneficiaryName'] ?? '',
      id: map['id'],
      typeKeyAccountPix: map['typeKeyAccountPix']??'',
      keyAccountPix: keyAccount,
    );
  }
}