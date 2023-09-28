// ignore_for_file: public_member_api_docs, sort_constructors_first


part of 'models.dart';

class SignUpModel extends Equatable {
  final String? name;
  final String? cpf;
  final String? email;
  final String? pincode;
  final String? phone;
  const SignUpModel({
    this.name,
    this.cpf,
    this.email,
    this.pincode,
    this.phone,
  });
  

  @override
  List<Object?> get props => [name, cpf, email, pincode, phone];


  Map<String, dynamic> toMap() {
    final map = <String,dynamic>{};
    if (name != null) {
      map['name'] = name;
    } 
    if (cpf != null) {
      map['cpf'] = cpf;
    }
    if (email != null) {
      map['email'] = email;
    }
    if (pincode != null) {
      map['pincode'] = pincode;
    }
    if (phone != null) {
      map['phone'] = phone;
    }
    return map;
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      name: map['name'] != null ? map['name'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      pincode: map['pincode'] != null ? map['pincode'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }


  SignUpModel copyWith({
    String? name,
    String? cpf,
    String? email,
    String? pincode,
    String? phone,
  }) {
    return SignUpModel(
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      pincode: pincode ?? this.pincode,
      phone: phone ?? this.phone,
    );
  }
}
