

part of 'models.dart';

class UserVerifyPin extends Equatable{
    final UserEntity user;
    final String password;
  const UserVerifyPin({
    required this.user,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'password': password,
    };
  }

  factory UserVerifyPin.fromMap(Map<String, dynamic> map) {
    return UserVerifyPin(
      user: UserDTO.fromMap(map['user'] as Map<String,dynamic>),
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserVerifyPin.fromJson(String source) => UserVerifyPin.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  List<Object?> get props => [
    user,password
  ];
}
