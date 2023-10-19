part of 'bloc.dart';

enum ListAccountsBankStatus { idle, loading, success, error }

class ListAccountBankState extends Equatable {
  final ListAccountsBankStatus status;
  final List<AccountBankEntity> accountsBank;
  final Failure? failure;
  const ListAccountBankState(
      {this.status = ListAccountsBankStatus.idle,
      this.accountsBank = const [],
      this.failure});


  List<AccountBankReceiverEntity> get receivers {
    final receiversAccount = accountsBank
        .where((element) => isReceiverAccountBank(element))
        .toList();
    return receiversAccount
        .map<AccountBankReceiverEntity>(
            (e) => AccountBankReceiverDTO.fromMap(e.data..['id'] = e.id))
        .toList();
  }

  List<AccountBankOriginEntity> get origins {
    final originsAccount = accountsBank
        .where((element) => !isReceiverAccountBank(element))
        .toList();
    return originsAccount
        .map<AccountBankOriginEntity>(
            (e) => AccountBankOriginDTO.fromMap(e.data..['id'] = e.id))
        .toList();
  }

  @override
  List<Object?> get props => [status, accountsBank, failure];

  bool isReceiverAccountBank(AccountBankEntity accountBankEntity) {
    return accountBankEntity.type == StringUtils.accountBankTypeReceiver;
  }

  ListAccountBankState copyWith(
      {ListAccountsBankStatus? status,
      List<AccountBankEntity>? accountsBank,
      Failure? failure}) {
    return ListAccountBankState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      accountsBank: accountsBank ?? this.accountsBank,
    );
  }
}
