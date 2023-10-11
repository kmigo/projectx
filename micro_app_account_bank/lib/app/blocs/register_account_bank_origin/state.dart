// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum RegisterAccountBankStatus { idle, loading, success, error }

class RegisterAccountBankState extends Equatable {
  final RegisterAccountBankStatus status;
  final String? failure;

   const RegisterAccountBankState.init({
     this.status = RegisterAccountBankStatus.idle,

    this.failure,
  }) ;
  const RegisterAccountBankState({
     this.status = RegisterAccountBankStatus.idle,
    this.failure,

  });
  @override
  List<Object?> get props => [status, failure];


  RegisterAccountBankState copyWith({
    RegisterAccountBankStatus? status,
    String? failure,
    AccountBankOriginModel? accountOrigin,
    AccountCreateModel? account
  }) {
    return RegisterAccountBankState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
