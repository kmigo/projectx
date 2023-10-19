// ignore_for_file: public_member_api_docs, sort_constructors_first




import 'package:micro_core/micro_core.dart';

part '../../dto/account_bank.dart';
class AccountBankEntity extends Equatable {
  final String id;
  final String? type;
  final dynamic data;
  final String? userId;
  final int? createdAt;
  final int? updatedAt;
  const AccountBankEntity({
    required this.id,
    this.type,
    required this.data,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });
  
  @override
  List<Object?> get props => [id, type, data, userId, createdAt, updatedAt];

  }
