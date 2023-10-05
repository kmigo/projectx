

import 'package:micro_core/micro_core.dart';

part '../../dto/account_create.dart';
class AccountEntity extends Equatable {
  final String? id;
  final String? type;
  final dynamic data;
  final String? userId;
  final int? createdAt;
  final int? updatedAt;
  const AccountEntity({
    this.id,
    this.type,
    required this.data,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });
  
  @override
  List<Object?> get props => [id, type, data, userId, createdAt, updatedAt];

  

 
}
