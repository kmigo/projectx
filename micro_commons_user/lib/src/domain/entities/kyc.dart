// ignore_for_file: public_member_api_docs, sort_constructors_first















import 'package:micro_core/micro_core.dart';

part '../../dto/kyc.dart';

class UserWithKycEntity extends Equatable {
  final num createAt;
  final String phone;
  final String document;
  final String birthDay;
  final String consumer;
  final String? username;
  final String? email;
  final String userId;
  final List pixData;
  final String id;
  final KycUserEntity? kyc;
  const UserWithKycEntity({
    required this.createAt,
    required this.phone,
    required this.document,
    required this.birthDay,
    required this.consumer,
    required this.userId,
    required this.pixData,
    required this.id,
     this.kyc,
     this.email,
     this.username
  });

  @override
  List<Object?> get props => [
    createAt,
    phone,
    document,
    birthDay,
    consumer,
    userId,
    pixData,
    id,
    kyc,
    email,
    username
    ];



  }

class KycUserEntity extends Equatable {
  final num? createAt;
  final String? flowId;
  final String? userId;
  final List<LevelRoleEntity> levels;
  const KycUserEntity({
    this.createAt,
    this.flowId,
    this.userId,
    required this.levels,
  });

  

  @override
  List<Object?> get props => [createAt, flowId, userId, levels];



 }



class LevelRoleEntity extends Equatable {
  final int? level;
  final bool? isValidate;
  final Map<String,dynamic>? data;
  final Map<String,dynamic>? error;
  final String? status;
  final RoleEntity? role;
  const LevelRoleEntity({
    this.level,

    this.isValidate,
    this.status,
    this.error,
    this.data,
    this.role
  });
  @override
  List<Object?> get props => [
    level,
    isValidate,
    status,
    data,
    role,
    error
  ];

  }

class RoleEntity extends Equatable {
  final String? name;
  final String? entity;
  final String? id;
  final DataRoleEntity? data;
  const RoleEntity({
    this.name,
    this.entity,
    this.id,
    this.data,
  });
  
  @override
  List<Object?> get props => [name,entity,id,data];



  
}

class DataRoleEntity extends Equatable{
    final RequiredRoleEntity? required;

    const DataRoleEntity({
        this.required,
    });
    @override
  List<Object?> get props => [required];
}


class RequiredRoleEntity extends Equatable {
  final List<FieldEntity>? or;
  final List<FieldEntity>? fields;
  const RequiredRoleEntity({
     this.or,
     this.fields
  });
  
  @override
  List<Object?> get props => [or,fields];



}


class FieldEntity extends Equatable {
  final String? field;
  final String? type;
  const FieldEntity({
    this.field,
    this.type,
  });
  
  @override
  List<Object?> get props => [
    field,
    type,];
  

}
