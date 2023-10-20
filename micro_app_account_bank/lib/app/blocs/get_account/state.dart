part of'bloc.dart';

enum GetAccountStatus {idle,loading,success,updated,error}

class GetAccountState extends Equatable {
  final GetAccountStatus status;
  final AccountBankEntity? account;
  final Failure? failure;
  const GetAccountState({
    required this.status,
    this.account,
    this.failure,
  });
  
  @override
  List<Object?> get props => [status,account,failure];

  GetAccountState copyWith({
    GetAccountStatus? status,
    AccountBankEntity? account,
    Failure? failure,
  }) {
    return GetAccountState(
      status: status ?? this.status,
      account: account ?? this.account,
      failure: failure ?? this.failure,
    );
  }
}
