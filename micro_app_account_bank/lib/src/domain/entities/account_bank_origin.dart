// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:micro_core/micro_core.dart';

part '../../dto/account_bank_origin.dart';
class AccountBankOriginEntity extends Equatable {
  final String bankName;
  final String account;
  final String accountNumber;
  final String routingNumber;
  final String accountHolder;
  final String label;
  const AccountBankOriginEntity({
    required this.bankName,
    required this.account,
    required this.accountNumber,
    required this.routingNumber,
    required this.accountHolder,
    required this.label,
  });
  
  @override
  List<Object?> get props => [bankName, account, accountNumber, routingNumber, accountHolder, label];

  



  }
