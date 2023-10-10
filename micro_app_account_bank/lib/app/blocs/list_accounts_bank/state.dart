// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

enum ListAccountsBankStatus {idle, loading, success, error}


class ListAccountBankState extends Equatable {
  final ListAccountsBankStatus status;
  final List<AccountBankEntity> accountsBank;
  final Failure? failure;
  const ListAccountBankState({
     this.status = ListAccountsBankStatus.idle,
     this.accountsBank = const [],
     this.failure
  });
  
  @override
  List<Object?> get props => [status, accountsBank,failure];

  bool isReceiverAccountBank(AccountBankEntity accountBankEntity){
    return accountBankEntity.type == StringUtils.accountBankTypeReceiver;
  }

  ListAccountBankState copyWith({
    ListAccountsBankStatus? status,
    List<AccountBankEntity>? accountsBank,
    Failure? failure
  }) {
    return ListAccountBankState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      accountsBank: accountsBank ?? this.accountsBank,
    );
  }
}
