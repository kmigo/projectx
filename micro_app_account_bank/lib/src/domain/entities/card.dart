// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:micro_core/micro_core.dart';

import 'account_bank_origin.dart';
import 'account_bank_receiver.dart';

part '../../dto/card.dart';

/*
    
     {
    "id": "Fi9KiqlPXFM8eji9ec4X",
    "name": "Aluguel",
    "receiver_account": {
      "created_at": 1697048298,
      "credential_id": null,
      "user_id": "h5gdy3kFeRO8fKio0FiMvMR6QCf1",
      "type": "RECEIVER_ACCOUNT",
      "document": null,
      "data": {
        "keyAccountPix": "158.657.427-28",
        "beneficiaryName": "Thomas Edison",
        "type": "KEY",
        "tagName": "Aluguel Barra",
        "typeBeneficiary": "Pessoa Júridica",
        "typeKeyAccountPix": "cpf"
      },
      "id": "Elo0h6h8Cc54zhKaQS2L"
    },
    "origin_account": {
      "created_at": 1697047830,
      "credential_id": null,
      "user_id": "h5gdy3kFeRO8fKio0FiMvMR6QCf1",
      "type": "ORIGIN_ACCOUNT",
      "document": null,
      "data": {
        "type": null,
        "accountNumber": "123465",
        "accountHolder": "Stione",
        "account": "ORIGIN_ACCOUNT",
        "bankName": "wild rift",
        "routingNumber": "123456",
        "label": "Melhor"
      },
      "id": "z4TzSKnfdOaCV5FM0c0P"
    },
    "user_id": "h5gdy3kFeRO8fKio0FiMvMR6QCf1",
    "created_at": 1697215488,
    "updated_at": null
  }
 */

class ReceiverAccountEntity extends Equatable {
  final int createdAt;
  final String? credentialId;
  final String userId;
  final String type;
  final String? document;
  final AccountBankReceiverEntity data;
  final String id;
  const ReceiverAccountEntity({
    required this.createdAt,
    this.credentialId,
    required this.userId,
    required this.type,
    this.document,
    required this.data,
    required this.id,
  });
  
  @override
  List<Object?> get props => [
    createdAt,credentialId,userId,type,document,data,id
  ];


 }

class ReceiverAccountBankDetailEntity extends Equatable {
  final String keyAccountPix;
  final String beneficiaryName;
  final String type;
  final String tagName;
  final String typeBeneficiary;
  final String typeKeyAccountPix;
  final String? id;
  const ReceiverAccountBankDetailEntity({
    required this.keyAccountPix,
    required this.beneficiaryName,
    required this.type,
    required this.tagName,
    required this.typeBeneficiary,
    required this.typeKeyAccountPix,
     this.id,
  });
  
  @override
  List<Object?> get props => [keyAccountPix,id,beneficiaryName,type,tagName,typeBeneficiary,typeKeyAccountPix];

 }

class OriginAccountEntity extends Equatable {
  final int createdAt;
  final String? credentialId;
  final String userId;
  final String type;
  final String? document;
  final AccountBankOriginEntity data;
  final String id;
  const OriginAccountEntity({
    required this.createdAt,
    this.credentialId,
    required this.userId,
    required this.type,
    this.document,
    required this.data,
    required this.id,
  });
  
  @override
  List<Object?> get props => [createdAt,credentialId,userId,type,document,data,id];





 
  }

class OriginAccountBankDetailEntity extends Equatable {
  final String? type;
  final String accountNumber;
  final String accountHolder;
  final String account;
  final String bankName;
  final String routingNumber;
  final String label;
  final String? id;
  const OriginAccountBankDetailEntity({
    this.type,
    required this.accountNumber,
    required this.accountHolder,
    required this.account,
    required this.bankName,
    required this.routingNumber,
    required this.label,
    this.id,
  });
  
  @override
  List<Object?> get props => [type,id,accountNumber,accountHolder,account,bankName,routingNumber,label];

  }

// class OriginAccountEntity {
//   final int createdAt;
//   final String? credentialId;
//   final String userId;
//   final String type;
//   final String? document;

// }


class CardEntity extends Equatable {
  final String id;
  final String name;
  final String userId;
  final int createdAt;
  final dynamic updatedAt;
  final ReceiverAccountEntity receiverAccount;
  final OriginAccountEntity originAccountEntity;
  const CardEntity({
    required this.id,
    required this.name,
    required this.userId,
    required this.createdAt,
    required this.originAccountEntity,
    required this.receiverAccount,
    this.updatedAt,
  });
  @override
  List<Object?> get props =>[id,name,userId,createdAt,updatedAt,originAccountEntity,receiverAccount];

    }
