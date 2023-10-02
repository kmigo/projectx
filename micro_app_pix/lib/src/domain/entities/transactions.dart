
import 'package:micro_core/micro_core.dart';

part '../../dtos/transaction.dart';
class TransactionEntity extends Equatable {
 
  final String id;
  final num amount;
  final num expectedAmout;
  final String status;
  final num createdAt;
  final num updatedAt;
  final String type;
  final String action;
  final UserTransactionEntity payer;
  final UserTransactionEntity receiver;
  final String description;
  final String identification;
  final String operationId;
  final String credentialId;
  const TransactionEntity({
    required this.id,
    required this.amount,
    required this.expectedAmout,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.action,
    required this.payer,
    required this.receiver,
    required this.description,
    required this.identification,
    required this.operationId,
    required this.credentialId,
  });
  
  @override
  List<Object?> get props =>[id,amount,expectedAmout,status,createdAt,updatedAt,type,action,payer,receiver,description,identification,operationId,credentialId];

}



class AccountDataEntity extends Equatable {
  final String safeId;
  const AccountDataEntity({
    required this.safeId,
  });
  
  @override
  List<Object?> get props => [safeId];
  const AccountDataEntity.empty():safeId='';
  
}
class UserTransactionEntity extends Equatable {
  final String name;
  final String userId; 
  final String document;
  final AccountDataEntity accountData;
  const UserTransactionEntity({
    required this.name,
    required this.document,
    required this.userId,
    required this.accountData,
  });

  const UserTransactionEntity.empty():name='',userId='',document='',accountData= const AccountDataEntity.empty();
  
  @override
  List<Object?> get props => [name,userId,document,accountData];
}
