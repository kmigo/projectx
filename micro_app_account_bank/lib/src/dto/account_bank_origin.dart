

part of '../domain/entities/account_bank_origin.dart';


extension AccountBankOriginDTO on AccountBankOriginEntity {
    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bankName': bankName,
      'account': account,
      'accountNumber': accountNumber,
      'routingNumber': routingNumber,
      'accountHolder': accountHolder,
      'label': label,
      'id': id,
    };
  }

  static fromMap(Map<String, dynamic> map) {

    return AccountBankOriginEntity(
      bankName: map['bankName'] ?? 'Sem nome',
      account: map['account'] ?? '----',
      id: map['id'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
      routingNumber: map['routingNumber'] ?? '',
      accountHolder: map['accountHolder'] ?? '',
      label: map['label'] ?? '',
    );
  }
}