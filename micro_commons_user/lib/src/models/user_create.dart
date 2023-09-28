



part of 'models.dart';

class UserCreateModel extends Equatable {
  final String cpf;
  final String birthDay;
  final String phone;
  final String password;
 const  UserCreateModel({
    required this.cpf,
    required this.birthDay,
    required this.phone,
    required this.password,
  });
  static empty() => const UserCreateModel(cpf: '', password: '',birthDay: '', phone: '', );
  @override
  List<Object?> get props => [cpf,birthDay,phone,password];


  UserCreateModel copyWith({
    String? cpf,
    String? birthDay,
    String? phone,
    String? password
  }) {
    return UserCreateModel(
      cpf: cpf ?? this.cpf,
      birthDay: birthDay ?? this.birthDay,
      phone: phone ?? this.phone,
      password: password ?? this.password
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'document': cpf,
      'birthDay': birthDay,
      'phone': phone,
      'pincode':password
    };
  }

  factory UserCreateModel.fromMap(Map<String, dynamic> map) {
    return UserCreateModel(
      cpf: map['document'] ?? '',
      birthDay: map['birthDay'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? ''
    );
  }

  
}
