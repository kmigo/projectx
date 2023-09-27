part of '../domain/entities/kyc.dart';


extension UserWithKycDTO on UserWithKycEntity {

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created_at': createAt,
      'phone': phone,
      'document': document,
      'birth_day': birthDay,
      'consumer': consumer,
      'username': username,
      'email': email,
      'user_id': userId,
      'pix_data': pixData,
      'id': id,
      'kyc': kyc?.toMap(),
    };
  }

  static fromMap(Map<String, dynamic> map) {

    return UserWithKycEntity(
      createAt: map['created_at'] as num,
      phone: map['phone'] as String,
      document: map['document'] as String,
      birthDay: map['birth_day'] as String,
      consumer: map['consumer'] as String,
      username: map['username'],
      email: map['email'],
      userId: map['user_id'] as String,
      pixData: List.from((map['pix_data'] as List)),
      id: map['id'] as String,
      kyc: map['kyc'] != null ? KycUserDTO.fromMap(map['kyc']) : null,
    );
  }
}

extension KycUserDTO on KycUserEntity {

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'create_at': createAt,
      'flow_id': flowId,
      'user_id': userId,
      'levels': levels.map((e) => e.toMap()).toList(),
    };
  }

  static  fromMap(Map<String, dynamic> map) {
    return KycUserEntity(
      createAt: map['create_at'] != null ? map['create_at'] as num : null,
      flowId: map['flow_id'] != null ? map['flow_id'] as String : null,
      userId: map['user_id'] != null ? map['user_id'] as String : null,
      levels: map['levels'] != null ? List<LevelRoleEntity>.from(map['levels'].map((e) => LevelRoleDTO.fromMap(e))) : [],
    );
  }

}

extension LevelRoleDTO on LevelRoleEntity {

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'level': level,
      'status': status,
      'error': error,
      'rule': role?.toMap(),
      'is_validate': isValidate,
      'data': data,
    };
  }

  static  fromMap( map) {
    return LevelRoleEntity(
      level: map['level'] ,
      isValidate: map['is_validate'] != null ? map['is_validate'] as bool : null,
      data: map['data'],
      error: map['error'],
      status: map['status'],
      role: map['rule'] != null ? RoleDTO.fromMap(map['rule']) : null,
    );
  }

}

extension RoleDTO on RoleEntity {
    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'entity': entity,
      'id': id,
      'data': data?.toMap(),
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return RoleEntity(
      name: map['name'] ,
      entity: map['entity'],
      id: map['id'] != null ? map['id'] as String : null,
      data: map['data'] != null ? DataRoleDTO.fromMap(map['data'] as Map<String,dynamic>) : null,
    );
  }
}

extension DataRoleDTO on DataRoleEntity {

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'required': required?.toMap(),
    };
  }

  static  fromMap(Map<String, dynamic> map) {
    return DataRoleEntity(
      required: map['required'] != null ? RequiredDTO.fromMap(map) : null,
    );
  }

}



extension RequiredDTO on RequiredRoleEntity {

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'or': or?.map((e) => e.toMap()).toList(),
      'fields':fields?.map((e) => e.toMap()).toList()
    };
  }

static fromMap(Map<String, dynamic> map) {
    // Lista de 'or' 
    List<dynamic>? orList = map['or'];
    List<FieldEntity>? or;
    if (orList != null) {
      or = orList
          .map((e) => e as Map<String, dynamic>)
          .map<FieldEntity>((e) => FieldDTO.fromMap(e))
          .toList();
    }

    // Lista de 'fields' 
    List<dynamic>? fieldsList = map['fields'];
    List<FieldEntity>? fields;
    if (fieldsList != null) {
      fields = fieldsList
          .map((e) => e as Map<String, dynamic>)
          .map<FieldEntity>((e) => FieldDTO.fromMap(e))
          .toList();
    }

    return RequiredRoleEntity(
      or: or,
      fields: fields ?? [],
    );
}

}


extension FieldDTO on FieldEntity {

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'field': field,
      'type': type,
    };
  }

  static  fromMap(Map<String, dynamic> map) {
    return FieldEntity(
      field: map['field'] != null ? map['field'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
    );
  }

}