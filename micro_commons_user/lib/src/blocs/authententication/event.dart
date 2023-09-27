part of 'bloc.dart';

abstract class AuthenticationEvent extends Equatable {}



class AuthenticationSignOutEvent extends AuthenticationEvent {
  AuthenticationSignOutEvent();
  @override
  List<Object?> get props => [];
}


class AuthenticationCurrentUserEvent extends AuthenticationEvent {
  AuthenticationCurrentUserEvent();
  @override
  List<Object?> get props => [];
}
class AuthenticationChangeStatusEvent extends AuthenticationEvent {
  final AuthenticationStatus status;
  AuthenticationChangeStatusEvent(this.status);
  @override
  List<Object?> get props => [status];
}
