part of '../domain/entities/user.dart';


extension WalletDTO on WalletEntity {

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brlnxt': brlnxt,
      'eth': eth,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return WalletEntity(
      brlnxt: map['XLM_TEST']  ?? 0,
      eth: map['ETH_TEST5'] ?? 0,
    );
  }
}
extension UserDTO on UserEntity {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'document': document,
      'first_name': firstName,
      'image': image,
      'phoneNumber': phoneNumber,
      'birthDay': birthDay,
      'username':username,
      'balance': balance,
      'address': address?.toMap() 
    };
  }

  static UserEntity fromMap(Map<String, dynamic>? map) {
    return UserEntity(
        id: map?['id'] ?? '',
        balance: map?['balance'] ?? 0,
        document: map?['document'] ?? '',
        firstName: map?['first_name'] ?? '',
        username: map?['username'],
        email: map?['email'],
        image: map?['image'] ?? '',
        phoneNumber: map?['phone'] ?? '',
        address: map?['address'] != null ? AddressDTO.fromMap(map?['address']) : null,
        birthDay: map?['birthDay'] ?? '');
  }
}

extension AddressDTO on AddressEntity {
    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cep': cep,
      'logradouro': street,
      'numero': number,
      'complemento': complement,
      'bairro': district,
      'cidade': city,
      'estado': state,
    };
  }

static fromMap(Map<String, dynamic> map) {
    return AddressEntity(
      cep: map['cep'] as String,
      street: map['logradouro'] as String,
      number: map['numero'] as String,
      complement: map['complemento'] as String,
      district: map['bairro'] as String,
      city: map['cidade'] as String,
      state: map['estado'] as String,
    );
  }
}