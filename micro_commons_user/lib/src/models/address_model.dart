// ignore_for_file: public_member_api_docs, sort_constructors_first



part of 'models.dart';

class AddressModel extends Equatable {
  final String? cep;
  final String? street;
  final String? number;
  final String? complement;
  final String? district;
  final String? city;
  final String? state;
  const AddressModel({
     this.cep,
     this.street,
     this.number,
     this.complement,
     this.district,
     this.city,
     this.state,
  });

  @override
  List<Object?> get props => [cep,street,number,complement,district,city,state];

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

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      cep: map['cep'],
      street: map['logradouro'] ,
      number: map['numero'] ,
      complement: map['complemento'] ,
      district: map['bairro'] ,
      city: map['cidade'] ,
      state: map['estado'],
    );
  }

  AddressModel copyWith({
    String? cep,
    String? street,
    String? number,
    String? complement,
    String? district,
    String? city,
    String? state,
  }) {
    return AddressModel(
      cep: cep ?? this.cep,
      street: street ?? this.street,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      district: district ?? this.district,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }
}
