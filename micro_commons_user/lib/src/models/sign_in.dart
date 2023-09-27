// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:micro_core/micro_core.dart';

class SignInModel extends Equatable {
  final String cpf;
  final String password;
  const SignInModel({
    required this.cpf,
    required this.password,
  });
  
  @override
  List<Object?> get props => [cpf, password];
}
