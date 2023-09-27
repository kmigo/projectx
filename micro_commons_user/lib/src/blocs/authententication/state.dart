
part of 'bloc.dart';
class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserEntity? user;


  const AuthenticationState({required this.status, this.user});
  @override
  List<Object?> get props => [user,status];

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    UserEntity? user,

  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
     
    );
  }
}
