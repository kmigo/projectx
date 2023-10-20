part of '../domain/entities/account_bank_receiver.dart';

extension AccountBankReceiverDTO on AccountBankReceiverEntity {
    Map<String, dynamic> toMap() {
      String keyAccount ='';

    if(['cpf','cnpj','telefone'].contains(typeKeyAccountPix.toLowerCase())){
      keyAccount = keyAccount.replaceAll(RegExp(r'\D'), '');
    }
    return <String, dynamic>{
      'tagName': tagName,
      'typeBeneficiary': typeBeneficiary,
      'beneficiaryName': beneficiaryName,
      'typeKeyAccountPix': typeKeyAccountPix,
      'keyAccountPix': keyAccount,
      'id': id,
    };
  }

  static AccountBankReceiverEntity fromMap(Map<String, dynamic> map) {
    
    
    return AccountBankReceiverEntity(
      tagName: map['tagName']??'' ,
      typeBeneficiary: map['typeBeneficiary'] ?? '',
      beneficiaryName: map['beneficiaryName'] ?? '',
      id: map['id'],
      typeKeyAccountPix: map['typeKeyAccountPix']??'',
      keyAccountPix: map['keyAccountPix']??'',
    );
  }
}