part of '../domain/entities/validate_key.dart';

extension ValidateKeyDTO on ValidateKeyEntity {
   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'owner': owner.toMap(),
      'key': key,
    };
  }

  static ValidateKeyEntity fromMap(Map<String, dynamic> map) {
    return ValidateKeyEntity(
      status: map['status'] as String,
      owner: OwnerDTO.fromMap(map['owner'] as Map<String,dynamic>),
      key: map['key'] as String,
    );
  }

  
}


extension OwnerDTO on OwnerEntity {
   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'documentNumber': documentNumber,
      'name': name,
    };
  }

  static OwnerEntity fromMap(Map<String, dynamic> map) {
    return OwnerEntity(
      type: map['type'] as String,
      documentNumber: map['documentNumber'] as String,
      name: map['name'] as String,
    );
  }

  
}