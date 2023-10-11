// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:micro_core/micro_core.dart';

import 'account_create_model.dart';

class AccountBankOriginModel extends Equatable implements AccountModel {
  final String bankName;
  final String account;
  final String accountNumber;
  final String routingNumber;
  final String accountHolder;
  final String label;
  const AccountBankOriginModel({
    required this.bankName,
    required this.account,
    required this.accountNumber,
    required this.routingNumber,
    required this.accountHolder,
    required this.label,
  });
  
  const AccountBankOriginModel.empty():
    bankName = '',
    account = '',
    accountNumber = '',
    routingNumber = '',
    accountHolder = '',
    label = '';
  
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bankName': bankName,
      'account': account,
      'accountNumber': accountNumber,
      'routingNumber': routingNumber,
      'accountHolder': accountHolder,
      'label': label,
    };
  }

  factory AccountBankOriginModel.fromMap(Map<String, dynamic> map) {
    return AccountBankOriginModel(
      bankName: map['bankName'] as String,
      account: map['account'] as String,
      accountNumber: map['accountNumber'] as String,
      routingNumber: map['routingNumber'] as String,
      accountHolder: map['accountHolder'] as String,
      label: map['label'] as String,
    );
  }
  
  @override
  List<Object?> get props => [bankName,account, accountNumber, routingNumber, accountHolder, label];


  AccountBankOriginModel copyWith({
    String? bankName,
    String? account,
    String? accountNumber,
    String? routingNumber,
    String? accountHolder,
    String? label,
  }) {
    return AccountBankOriginModel(
      bankName: bankName ?? this.bankName,
      account: account ?? this.account,
      accountNumber: accountNumber ?? this.accountNumber,
      routingNumber: routingNumber ?? this.routingNumber,
      accountHolder: accountHolder ?? this.accountHolder,
      label: label ?? this.label,
    );
  }
   }
