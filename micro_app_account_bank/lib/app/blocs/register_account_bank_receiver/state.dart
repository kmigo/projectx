// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum RegisterAccountBankReceiverStatus { idle, loading, success, error }

class RegisterAccountBankReceiverState extends Equatable {
  final RegisterAccountBankReceiverStatus status;
  final String? failure;

   const RegisterAccountBankReceiverState.init({
     this.status = RegisterAccountBankReceiverStatus.idle,
    this.failure,
  }) ;

  const RegisterAccountBankReceiverState({
     this.status = RegisterAccountBankReceiverStatus.idle,
    this.failure,
  });

  @override
  List<Object?> get props => [status, failure];


  RegisterAccountBankReceiverState copyWith({
    RegisterAccountBankReceiverStatus? status,
    String? failure,
    AccountBankOriginModel? accountOrigin,
    AccountCreateModel? account
  }) {
    return RegisterAccountBankReceiverState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
