// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum PasswordStatus { idle, loading, success, nextStep,failure }

class PasswordState extends Equatable {
  final PasswordStatus status;
  final Failure? failure;
  final int step;
  final String? password;
  final String? newPassword;
  final String? confirmPassword;
  const PasswordState({required this.status, this.failure,  this.step = 0, this.password, this.newPassword, this.confirmPassword});
  @override
  List<Object?> get props => [status, failure, step, password, newPassword, confirmPassword];


  PasswordState copyWith({
    PasswordStatus? status,
    Failure? failure,
    int? step,
    String? password,
    String? newPassword,
    String? confirmPassword,
  }) {
    return PasswordState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      step: step ?? this.step,
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  bool validatePassword(String? password){
    if(password == null) return false;
    if(password.length < 6){
      return false;
    }
    return true;
  }
}
